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
    let email: String
    let id: String
    var interests: [Interests] = [
        Interests(name: "Business", isOn: true),
        Interests(name: "Politics", isOn: true),
        Interests(name: "Sports", isOn: true),
        Interests(name: "Medicine", isOn: true)
    ]
   
    var favoriteArticles: [News.Article] = []
    
    init(email: String, id: String = UUID().uuidString) {
        self.email = email
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

extension Profile {
    var representation: [String : Any] {
        ["email" : email, "id" : id]
    }
    convenience init?(_ data: [String : Any]) {
        guard let id = data["id"] as? String,
              let email = data["email"] as? String else { return nil }
        self.init(email: email, id: id)
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


enum CustomError: Error {
    case invalidDocumentSnapshot
    case invalidDataInSnapshot
}
