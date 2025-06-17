//
//  SignUpViewModel.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 04.03.2025.
//

import Foundation
import FirebaseAuth

@Observable final
class SignUpViewModel {
    var profile: Profile?
  
    func login(email: String, password: String) async throws {
           let user = try await AuthServices.signIn(email: email, password: password)
            await MainActor.run {
                self.profile = user
            
        }
    }
    func createAccount(email: String, password: String) async throws {
        let user = try await AuthServices.createUser(email: email, password: password)
        await MainActor.run {
            self.profile = user
        }
    }
    
}



