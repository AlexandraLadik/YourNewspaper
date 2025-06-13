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
            TabView {
                Tab("For You", systemImage: "house") {
                    NewsView(viewModel: .init(userID: userID), settingsVM: .init())
                }
                Tab("Top Stories", systemImage: "newspaper") {
                    TopStoriesView()
                }
                Tab("Favorites", systemImage: "star") {
                    
                }
            }
            .font(.tabFont)
            .tint(.customBlue)
        
        case .unAuth:
            SignUpView(viewModel: .init(), coordinator: .init())
        }
    }
}

enum AppState {
    case auth (userID: String)
    case unAuth
}
