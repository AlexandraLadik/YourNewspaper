//
//  AuthServices.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 10.03.2025.
//

import Foundation
import FirebaseAuth

actor AuthServices {
    static let auth = Auth.auth()
    static var currentUser: User? { auth.currentUser }
    
    //MARK: Create user
    static  func createUser(email: String, password: String) async throws -> User {
        let result = try await auth.createUser(withEmail: email, password: password)
        let user = result.user
        return user
    }
    
    //MARK: Sign in
    
    static func signIn(email: String, password: String) async throws -> User {
        let result = try await auth.signIn(withEmail: email, password: password)
        let user = result.user
        return user
    }
    
    //MARK: Sign out
    
    static func signOut() async -> Bool {
        do {
            try auth.signOut()
            return true
        } catch {
            return false
        }
    }
    
}
