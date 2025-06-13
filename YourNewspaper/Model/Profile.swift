//
//  User.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 23.02.2025.
//

import Foundation
import SwiftUI

@Observable
final class Profile {
    var name: String
    let email: String
    let password: String
    let id: String
    var interests: [Interests] = [
        Interests(name: "Business", isOn: true),
        Interests(name: "Politics", isOn: true),
        Interests(name: "Sports", isOn: true),
        Interests(name: "Medicine", isOn: true)
    ]
   
    var favoriteArticles: [News.Article] = []
    
    init(name: String, email: String, password: String, id: String = UUID().uuidString) {
        self.name = name
        self.email = email
        self.password = password
        self.id = id
        
    }
    func addToFavorites(article: News.Article) {
        if !favoriteArticles.contains(where: { $0.title == article.title }) {
            favoriteArticles.append(article)
        }
        else {
            favoriteArticles.removeAll(where: { $0.title == article.title })
        }
    }
}
@Observable
final class Interests: Identifiable, Hashable {
    let id = UUID()
    let name: String
    var isOn: Bool
    
    init(name: String, isOn: Bool) {
        self.name = name
      self.isOn = isOn
    }
    static func == (lhs: Interests, rhs: Interests) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}


