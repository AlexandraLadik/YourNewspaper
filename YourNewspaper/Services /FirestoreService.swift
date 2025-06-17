//
//  FirestoreService.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 16.06.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

actor FirestoreService {
    static let database = Firestore.firestore()
    static var profilesRef: CollectionReference { database.collection("profiles")}
    
    static func createProfile(user: User) async throws -> Profile {
        let profile = Profile(email: user.email!, id: user.uid)
        try await profilesRef.document(user.uid).setData(profile.representation)
        return profile
    }
    static func fetchProfile(id: String) async throws -> Profile {
        let snapshot = try await profilesRef.document(id).getDocument()
        guard let data = snapshot.data() else {
            throw CustomError.invalidDocumentSnapshot
        }
        guard let profile = Profile(data) else { throw CustomError.invalidDataInSnapshot }
        return profile
    }
}
