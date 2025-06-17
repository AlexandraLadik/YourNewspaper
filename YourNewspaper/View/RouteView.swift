//
//  MainView.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 25.02.2025.
//
import SwiftUI

struct RouteView: View {
    private let coordinator = Coordinator()
    var body: some View {
            switch coordinator.appState {
            case .auth(userID: let userID):
                TabView {
                    Tab("For You", systemImage: "house") {
                        NewsView(viewModel: .init(userID: userID), settingsVM: .init(userID: userID))
                            .environment(coordinator)
                    }
                    Tab("Top Stories", systemImage: "newspaper") {
                        TopStoriesView(viewModel: .init(userID: userID))
                    }
                    Tab("Favorites", systemImage: "star") {
                        FavoritesView(viewModel: .init(userID: userID))
                    }
                }
              .font(.tabFont)
              .tint(.customBlue)
                
            case .unAuth:
                SignUpView(viewModel: .init())
                    .environment(coordinator)
            }
        }
    
}

enum AppState {
    case auth (userID: String)
    case unAuth
}
