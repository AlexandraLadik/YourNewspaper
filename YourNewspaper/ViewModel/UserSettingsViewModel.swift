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
    var user: Profile
    let language = ["English", "Russian", "German", "Italian", "Spanish"]
    var pickedLanguage = "English"
    
    init(user: Profile, pickedLanguage: String = "English") {
        self.user = user
        self.pickedLanguage = pickedLanguage
    }
    
    func addNewInterest(name: String) {
        guard !user.interests.contains(where: { $0.name == name }) else { return }
            let newInterest = Interests(name: name, isOn: true)
            user.interests.append(newInterest)
    }
    
    func deleteInterest(name: String) {
        user.interests.removeAll { $0.name == name }
    }
    
}



