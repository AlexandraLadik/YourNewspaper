//
//  FavouritesViewModel.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 24.06.2025.
//

import Foundation

@Observable
class FavouritesViewModel {
    var profile: Profile = .init(email: "", name: "")
    let userID: String
    var favoriteArticles: [News.Article] = []
    
    init(userID: String) {
        self.userID = userID
        Task {
            let profile = try await FirestoreService.fetchProfile(id: userID)
            await MainActor.run {
                self.profile = profile
            }
        }
        self.favoriteArticles = profile.favoriteArticles
    }
}
