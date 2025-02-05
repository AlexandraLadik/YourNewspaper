//
//  UserSettingsViewModel.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 08.03.2025.
//

import Foundation
import SwiftUI

@Observable
final class UserSettingsViewModel {
    var user: Profile?
    let language = ["English", "Russian", "German", "Italian", "Spanish"]
    var pickedLanguage = "English"
    
    var interests: [Interests] = [
        Interests(name: "Business", isOn: true),
        Interests(name: "Politics", isOn: true),
        Interests(name: "Sports", isOn: true),
        Interests(name: "Medicine", isOn: true)
    ]
   
    var onInterests: [Interests] {
            interests.filter { $0.isOn }
        }
    
    func addNewInterest(name: String) {
        guard !interests.contains(where: { $0.name == name }) else { return }
            let newInterest = Interests(name: name, isOn: true)
            interests.append(newInterest)
    }
    
    func deleteInterest(name: String) {
        interests.removeAll { $0.name == name }
    }
    
}



