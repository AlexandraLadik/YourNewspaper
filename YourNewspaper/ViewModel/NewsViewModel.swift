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
    var searchtext = ""
    
    init() {
        fetchDatabyWord(searchWord: searchtext)
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


