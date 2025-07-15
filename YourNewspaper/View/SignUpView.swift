//
//  SignUpView.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 04.03.2025.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @State var viewModel = SignUpViewModel()
    @State var name: String = ""
    @State var email: String = ""
    @State var pass: String = ""
    @State var isAuth: Bool = false
    @State private var showErrorAlert = false
    @State private var errorMessage: String = ""
    @Bindable var coordinator: Coordinator
    var body: some View {
        VStack(spacing: 24) {
            Text(isAuth ? "Sign In" : "Sign Up")
                .font(.newsTitle)
                .padding(24)
            
            VStack (spacing: 24) {
                CustomTextField(textInput: $email, placeholder: "Email", hasEye: false)
                CustomTextField(textInput: $pass, placeholder: "Password", hasEye: true)
                
                if !isAuth {
                    Text("By continuing, you agree to the Terms of Use. Read our Privacy Policy.")
                        .font(.newsText)
                        .foregroundStyle(.customBlue)
                    Button("Create account") {
                        Task {
                            try await viewModel.createAccount(email: self.email, password: self.pass)
                            if let profile = viewModel.currentUser {
                                coordinator.appState = .auth(userID: profile.id) }
                        
                            email = ""
                            pass = ""
                        }
                        
                    }
                    
                    
                    Spacer()
                    Button("Already have an account?") { isAuth = true }
                }
                else {
                    Button("Sign In") {
                        guard !email.isEmpty, !pass.isEmpty else {
                                   errorMessage = "Заполните все поля"
                                   showErrorAlert = true
                                   return
                               }
                        Task {
                            do {
                                try await viewModel.login(email: self.email, password: self.pass)
                                if let profile = viewModel.currentUser {
                                    coordinator.appState = .auth(userID: profile.id)
                                }
                            } catch {
                                errorMessage = "Неверные учетные данные"
                                showErrorAlert = true
                            }
                        }
                    }
                    .alert("Error", isPresented: $showErrorAlert) {
                        Button("OK") {  }
                    } message: {
                        Text(errorMessage)
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
    SignUpView(viewModel: .init(), coordinator: .init())
}
