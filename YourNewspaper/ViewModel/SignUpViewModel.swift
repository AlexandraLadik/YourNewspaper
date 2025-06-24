//
//  SignUpViewModel.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 04.03.2025.
//

import Foundation
import FirebaseAuth

@Observable
class SignUpViewModel {
    @MainActor
    func login(email: String, password: String) async throws -> String {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        return result.user.uid
    }
    
    @MainActor
    func createAccount(email: String, password: String) async throws -> String {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        return result.user.uid
    }
}



