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
    let userID: String
    var profile: Profile = .init(email: "", name: "")
    var favoriteArticles: [News.Article] = []
    
    init(userID: String) {
        self.userID = userID
        Task {
            let profile = try await FirestoreService.fetchProfile(id: userID)
            await MainActor.run {
                self.profile = profile
            }
        }
        self.favoriteArticles = profile.favoriteArticles
        fetchDatabyWord(searchWord: "")
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
    
    }


