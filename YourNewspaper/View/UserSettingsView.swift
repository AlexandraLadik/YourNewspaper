//
//  UserSettingsView.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 08.03.2025.
//

import SwiftUI

struct UserSettingsView: View {
    @Bindable var viewModel: UserSettingsViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresented = false
    @Bindable var coordinator: Coordinator

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Language")
                        .font(.newsText)
                    Spacer()
                    Picker ("Language", selection: $viewModel.pickedLanguage) {
                        ForEach(viewModel.language, id: \.self) { language in
                            Text(language)
                        }
                    }
                    
                }
                
                Text("Topics")
                    .font(.newsTitle)
                    .padding()
                List($viewModel.user.interests) { $interest in
                    HStack {
                        Text(interest.name)
                            .font(.newsText)
                        Spacer()
                        Toggle("", isOn: $interest.isOn)
                        
                    }
                    .toggleStyle(CheckToggleStyle())
                  .padding(.vertical, 13)
                    .swipeActions(edge: .trailing) {
                        Button(action: { viewModel.deleteInterest(name: interest.name) }, label: {
                            Label("Delete", systemImage: "trash")
                            .tint(.red) })
                    }
                    
                }
            }
            .padding(.horizontal, 16)
                
                .listStyle(.plain)
                
            Spacer()
               
            VStack(spacing: 30) {
                Button {
                    isPresented = true
                } label: {
                    Text("Add custom topic")
                        .font(.newsTitle)
                }
               Button("Сохранить интересы") {
                    Task {
                       await viewModel.updateProfileInterests()
                    }
                }
                
                Button {
                    Task {
                        await viewModel.signOut() ? coordinator.appState = .unAuth : print("Cant sign out")
                    }
                } label: {
                    Text("Sign Out")
                        .font(.newsTitle)
                }
             
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Settings").font(.newsTitle)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark")
                        }
                        .tint(.black)
                    }
                }
                .sheet(isPresented: $isPresented) {
                    AddNewCustomTopicView(viewModel: viewModel)
                }
            }
            
        }
        .onChange(of: scenePhase) { newPhase, _ in
            if newPhase == .inactive {
                Task { await viewModel.updateProfileInterests() }
            }
        }
            }
        }
    

