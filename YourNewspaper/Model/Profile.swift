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
    
    init(email: String, id: String = UUID().uuidString) {
        self.email = email
        self.id = id
        self.interests = interests
    }
    
}
extension Profile {
    var representation: [String: Any] {
        [
            "email": email,
            "id": id,
            "interests": interests.map { $0.respresentation }
        ]
    }
    
    convenience init?(_ data: [String: Any]) {
        guard let id = data["id"] as? String,
              let email = data["email"] as? String,
              let interestsData = data["interests"] as? [[String: Any]]
        else { return nil }
        
        self.init(email: email, id: id)
        
        self.interests = interestsData.compactMap { Interests($0) }
        
        if self.interests.isEmpty {
            self.interests = [
                Interests(name: "Business", isOn: true),
                Interests(name: "Politics", isOn: true),
                Interests(name: "Sports", isOn: true),
                Interests(name: "Medicine", isOn: true)
            ]
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
    
    var respresentation: [String : Any] {
        ["name" : name, "isOn" : isOn]
    }
    convenience init?(_ data: [String : Any]) {
        guard let name = data["name"] as? String,
              let isOn = data["isOn"] as? Bool
        else { return nil }
      
        self.init(name: name, isOn: isOn)
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
