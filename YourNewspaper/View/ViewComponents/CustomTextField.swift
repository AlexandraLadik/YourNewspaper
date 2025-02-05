//
//  CustomTextField.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 04.03.2025.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var textInput: String
    var placeholder: String
    @State var isSecure: Bool
    var hasEye: Bool = false
    
    init(textInput: Binding<String>, placeholder: String, hasEye: Bool) {
        _textInput = textInput
        self.placeholder = placeholder
        self._isSecure = State(initialValue: hasEye)
        self.hasEye = hasEye
    }
    var body: some View {
        HStack {
            if hasEye {
                HStack {
                    if isSecure {
                        SecureField("", text: $textInput,
                                    prompt: Text(placeholder)
                            .foregroundColor(.customBlue))
                        .modifier(BlueTextField())
                        
                    } else {
                        TextField("", text: $textInput,
                                  prompt: Text(placeholder)
                            .foregroundColor(.customBlue))
                        .modifier(BlueTextField())
                    }
                }
                .frame(maxWidth: .infinity)
                .overlay(alignment: .trailing) {
                    Button {
                        isSecure.toggle()
                    } label: {
                        Image(systemName: isSecure ? "eye" : "eye.slash")
                            .foregroundStyle(.customBlue)
                    }
                    
                        .padding()
                }
            } else {
                TextField("", text: $textInput,
                          prompt: Text(placeholder)
                    .foregroundColor(.customBlue)
                )
                .modifier(BlueTextField())
                
                
            }
            
            
        }
        .frame(height: 56)
    }
    struct BlueTextField: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding()
                .font(.newsText)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(.customBlue))
                }
        }
    }
}
