//
//  FavouritesViewModel.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 24.06.2025.
//

import Observation
import FirebaseFirestore

@Observable
final class FavouritesViewModel {
    var favoriteArticles: [News.Article] = []
    private var listener: ListenerRegistration?
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
        startListener()
    }
    
    private func startListener() {
        let query = FirestoreService.articlesRef
            .document(userId)
            .collection("articles")
        
        listener = query.addSnapshotListener { [weak self] snapshot, error in
            guard let self else { return }
            
            if let error {
                print("Error fetching articles: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents")
                return
            }
            
            favoriteArticles = documents.compactMap { doc in
                try? doc.data(as: News.Article.self)
            }
        }
    }
    
    func toggleFavorite(article: News.Article) {
        Task {
            do {
                let articleRef = FirestoreService.articlesRef
                    .document(userId)
                    .collection("articles")
                    .document(article.title)
                
                let snapshot = try await articleRef.getDocument()
                if snapshot.exists {
                    try await articleRef.delete()
                } else {
                    try articleRef.setData(from: article)
                }
            } catch {
                print("Error toggling favorite: \(error.localizedDescription)")
            }
        }
    }
    
    deinit {
        listener?.remove()
    }
}
