//
//  SignUpView.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 04.03.2025.
//

import SwiftUI

struct SignUpView: View {
    @State var viewModel: SignUpViewModel
    @State var name: String = ""
    @State var email: String = ""
    @State var pass: String = ""
    @State var isAuth: Bool = false
    @Environment(Coordinator.self) private var coordinator
    var body: some View {
        VStack(spacing: 24) {
            Text(isAuth ? "Sign In" : "Sign Up")
                .font(.newsTitle)
                .padding(24)
            
            VStack (spacing: 24) {
                CustomTextField(textInput: $email, placeholder: "Email", hasEye: false)
                CustomTextField(textInput: $pass, placeholder: "Password", hasEye: true)
                
                if !isAuth {
                    CustomTextField(textInput: $name, placeholder: "UserName", hasEye: false)
                    Text("By continuing, you agree to the Terms of Use. Read our Privacy Policy.")
                        .font(.newsText)
                        .foregroundStyle(.customBlue)
                    Button("Create account") {
                        Task {
                            try await viewModel.createAccount(email: self.email, password: self.pass)
                            if let profile = viewModel.profile {
                                coordinator.appState = .auth(userID: profile.id)
                            }
                        }
                        
                        name.removeAll()
                        email.removeAll()
                        pass.removeAll()
    
                    }
                    Spacer()
                    Button("Already have an account?") { isAuth = true }
                }
                    if isAuth {
                        Button("Sign in") {
                            Task {
                                try await viewModel.login(email: self.email, password: self.pass)
                                if let user = viewModel.profile {
                                    coordinator.appState = .auth(userID: user.id)
                                }
                            }
                        }
                        Spacer()
                        Button("Don't have an account?") { isAuth = false }
                        
                    }
                    
                }
            }
            .font(.newsTitle)
            .tint(.black)
            .padding(.horizontal, 16)
           
        }
    }
        
    
 
#Preview {
    SignUpView(viewModel: .init())
}
