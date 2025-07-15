//
//  UserSettingsViewModel.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 08.03.2025.
//

import Foundation
import SwiftUI
import FirebaseFirestore

@Observable
final class UserSettingsViewModel {
    var user: Profile = .init(email: "")
    let userID: String
    let language = ["English", "Russian", "German", "Italian", "Spanish"]
    var pickedLanguage = "English"
   
    
    init(userID: String) {
        self.userID = userID
       
    }
    
   
    func addNewInterest(name: String) {
        guard !user.interests.contains(where: { $0.name == name }) else { return }
        
        let newInterest = Interests(name: name, isOn: true)
        user.interests.append(newInterest)
       
    }
    
    func deleteInterest(name: String) {
        user.interests.removeAll { $0.name == name }
        
    }
    
    func toggleInterest(_ interest: Interests) {
        if let index = user.interests.firstIndex(where: { $0.id == interest.id }) {
            user.interests[index].isOn.toggle()
           
        }
    }
    
    
    func updateProfileInterests() async {
        let interestsData = user.interests.map { $0.respresentation }
               
               do {
                   try await Firestore.firestore()
                       .collection("profiles")
                       .document(userID)
                       .updateData(["interests": interestsData])
               } catch {
                   print("Ошибка сохранения интересов: \(error)")
               }
    }
    
    func signOut() async -> Bool {
        await AuthServices.signOut()
    }
}
