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
    static var profilesRef: CollectionReference { database.collection("profile")}
    static var articlesRef: CollectionReference { database.collection("articles")}
    
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
    
    static func addFavoriteArticle(article: News.Article, id: String) async throws {
        let documentRef = articlesRef.document(id)
           
           try await documentRef.updateData([
               "articles": FieldValue.arrayUnion([article.representation])
           ])
    }

    
    static func fetchFavoriteArticles(id: String) async throws -> [News.Article] {
        let snapshot = try await articlesRef.document(id).getDocument()
        
        guard let data = snapshot.data(),
              let articlesData = data["articles"] as? [[String: Any]]
        else {
            throw CustomError.invalidDocumentSnapshot
        }
        
        return articlesData.compactMap { News.Article($0) }
    }
    static func removeFavoriteArticle(article: News.Article, id: String) async throws {
        let documentRef = articlesRef.document(id)
        
        try await documentRef.updateData([
            "articles": FieldValue.arrayRemove([article.representation])
        ])
    }
}


