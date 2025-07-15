//
//  MainView.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 25.02.2025.
//
import SwiftUI

struct RouteView: View {
    @State var coordinator = Coordinator()
    var body: some View {
            switch coordinator.appState {
            case .auth(userID: let userID):
                MainRouteView(storage: MainRouteStorage(userID: userID))
                    .environment(coordinator)
            case .unAuth:
                SignUpView(coordinator: coordinator)
            }
        }
    
}

enum AppState {
    case auth (userID: String)
    case unAuth
}
