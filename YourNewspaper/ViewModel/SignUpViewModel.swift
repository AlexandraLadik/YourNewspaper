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
    var currentUser: Profile? = nil
    
    
    func login(email: String, password: String) async throws {
        let profile = try await AuthServices.signIn(email: email, password: password)
        await MainActor.run {
            self.currentUser = profile
        }
    }
    
    
    func createAccount(email: String, password: String, name: String) async throws {
        let profile = try await AuthServices.createUser(email: email, password: password)
        await MainActor.run {
            self.currentUser = profile
        }
    }
}



