//
//  User.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 23.02.2025.
//

import Foundation
import SwiftUI

final class Profile {
    var name: String
    let email: String
    let password: String
    let id: String
    static var guest = Profile(name: "Anonym", email: "anonym", password: "anonym")
    
    init(name: String, email: String, password: String, id: String = UUID().uuidString) {
        self.name = name
        self.email = email
        self.password = password
        self.id = id
        
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


