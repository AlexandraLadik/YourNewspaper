//
//  MainRouteView.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 02.07.2025.
//

import SwiftUI

struct MainRouteView: View {
    @State var storage: MainRouteStorage
    
    var body: some View {
        TabView {
            if let profile = storage.profile {
                Tab("For You", systemImage: "house") {
                    NewsView(viewModel: .init(),
                             settingsVM: .init(user: profile, userID: profile.id), favVM: .init(userId: profile.id))
                    .environment(profile)
                }
                Tab("Top Stories", systemImage: "newspaper") {
                    TopStoriesView(viewModel: .init(), favVM: .init(userId: profile.id))
                        .environment(profile)
                }
                Tab("Favorites", systemImage: "star") {
                    FavoritesView(viewModel: .init(userId: profile.id))
                        .environment(profile)
                }
            } else {
                Tab {
                    Text("Profile not found")
                }
            }
        }
        .font(.tabFont)
        .tint(.customBlue)
    }
}
