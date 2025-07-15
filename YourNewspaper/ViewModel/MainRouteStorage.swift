//
//  MainRouteStorage.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 02.07.2025.
//

import Foundation

@Observable
class MainRouteStorage {
    let userID: String
    var profile: Profile?
    
    init(userID: String) {
        self.userID = userID
        Task {
            let profile = try await FirestoreService.fetchProfile(id: userID)
            await MainActor.run {
                self.profile = profile
                
            }
        }
    }

}
