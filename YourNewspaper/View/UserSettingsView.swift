//
//  UserSettingsView.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 08.03.2025.
//

import SwiftUI

struct UserSettingsView: View {
    @State var viewModel = UserSettingsViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var isPresented = false

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
                ForEach($viewModel.interests) { $interest in
                    HStack {
                        Text(interest.name)
                            .font(.newsText)
                        Spacer()
                        Toggle("", isOn: $interest.isOn)
                            
                    }
                    .toggleStyle(CheckToggleStyle())
                    .padding(.vertical, 13)
                    
                   
                }
            }
            .padding()
                Button {
                    isPresented = true
                } label: {
                    Text("Add custom topic")
                        .font(.newsTitle)
                }

                
                Spacer()
                
            
           
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
            
        }
            }
        }
    

#Preview {
    UserSettingsView(viewModel: .init())
}
