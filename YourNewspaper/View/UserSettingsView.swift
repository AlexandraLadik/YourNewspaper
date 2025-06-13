//
//  UserSettingsView.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 08.03.2025.
//

import SwiftUI

struct UserSettingsView: View {
    @State var viewModel: UserSettingsViewModel
    @Environment(\.dismiss) var dismiss
    @State private var isPresented = false
    @State var coordinator: Coordinator

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
                        Button(action: {viewModel.deleteInterest(name: interest.name) }, label: {
                            Label("Delete", systemImage: "trash")
                            .tint(.red) })
                    }
                    
                }
            }
                
                .listStyle(.plain)
                
                .padding()
               
            VStack {
                Button {
                    isPresented = true
                } label: {
                    Text("Add custom topic")
                        .font(.newsTitle)
                }
                Spacer()
                Button {
                    Task {
                        await AuthServices.signOut() ? coordinator.appState = .unAuth : ()
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
            }
        }
    

#Preview {
    UserSettingsView(viewModel: .init(user: .init(name: "", email: "", password: "")), coordinator: .init())
}
