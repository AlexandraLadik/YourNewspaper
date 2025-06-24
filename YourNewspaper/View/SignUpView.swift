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
    @State private var errorMessage = ""
    @State private var showErrorAlert = false
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
                    CustomTextField(textInput: $name, placeholder: "UserName", hasEye: false)
                    Text("By continuing, you agree to the Terms of Use. Read our Privacy Policy.")
                        .font(.newsText)
                        .foregroundStyle(.customBlue)
                    Button("Create account") {
                        Task {
                            do {
                             let userID = try await viewModel.createAccount(email: email, password: pass)
                                    coordinator.appState = .auth(userID: userID)
                                    
                                    
                                    name = ""
                                    email = ""
                                    pass = ""
                                }
                             catch {
                                print("Error creating account:", error.localizedDescription)
                                // TODO: Здесь можно показать alert с ошибкой
                            }
                        }
                        
                    }
                    Spacer()
                    Button("Already have an account?") { isAuth = true }
                }
                if isAuth {
                    Button("Sign In") {
                        Task {
                            do {
                                let userID = try await viewModel.login(email: email, password: pass)
                                coordinator.appState = .auth(userID: userID)
                            } catch {
                                errorMessage = error.localizedDescription
                            }
                        }
                    }
                    .alert("Error", isPresented: $showErrorAlert) {
                        Button("OK") { errorMessage = "" }
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
