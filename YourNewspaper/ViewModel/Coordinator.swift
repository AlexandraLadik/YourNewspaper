//
//  Coordinator.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 07.03.2025.
//

import SwiftUI

@Observable final
class Coordinator {
    var appState: AppState = .unAuth {
        didSet { print("Состояние изменилось:", appState) } 
    }
    
    init() {
        if let currentUser = AuthServices.currentUser {
            appState = .auth(userID: currentUser.uid)
        } else {
            appState = .unAuth
        }
    }
}
