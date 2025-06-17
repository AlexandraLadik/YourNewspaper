//
//  NewsViewModel.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 23.02.2025.
//

import SwiftUI

@Observable final
class NewsViewModel {
    var news: News?
    var searchWord: String = ""
    let sortBy = ["relevancy", "popularity", "publishedAt"]
    let userID: String
    var currentUser: Profile = .init(email: "")
    
    init(userID: String) {
        self.userID = userID
        Task {
            let profile = try await FirestoreService.fetchProfile(id: userID)
            await MainActor.run {
                self.currentUser = profile
            }
        }
        fetchDatabyWord(searchWord: searchWord)
    }
    
    
    func fetchDatabyWord(searchWord: String)  {
        if searchWord.isEmpty {
            Task {
                let news = try await NetworkService.shared.fetchNews()
                await MainActor.run {
                    self.news = news
                }
            }
        } else {
            Task {
                let news = try await NetworkService.shared.fetchSearchNews(searchWord: searchWord)
                await MainActor.run {
                    self.news = news
                }
            }
        }
       
    }
    //TODO: Sort by 
}
