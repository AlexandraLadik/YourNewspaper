//
//  AddNewCustomTopicView.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 14.06.2025.
//

import SwiftUI

struct AddNewCustomTopicView: View {
    @State var viewModel: UserSettingsViewModel
    @Environment(\.dismiss) var dismiss
    @State private var textInput = ""
    var body: some View {
        NavigationStack {
            VStack {
                CustomTextField(textInput: $textInput, placeholder: "topic name", hasEye: false)
                    .padding(.vertical, 16)
                Button("Save") {
                    viewModel.addNewInterest(name: textInput)
                    dismiss()
                }
                
            }
            .font(.newsTitle)
            .tint(.black)
            .padding()
            
        
            Spacer()
        
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Add topic").font(.newsTitle)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    textInput = ""
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
    
   
