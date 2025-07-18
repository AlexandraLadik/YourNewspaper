//
//  Coordinator.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 07.03.2025.
//

import SwiftUI
import FirebaseAuth

@Observable final class Coordinator {
    var appState: AppState = .unAuth
    
    init() {
        if let currentUser = AuthServices.currentUser {
            appState = .auth(userID: currentUser.uid)
        } else {
            appState = .unAuth
        }
    }
}
