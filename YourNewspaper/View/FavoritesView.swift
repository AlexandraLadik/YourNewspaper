//
//  FavoritesView.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 14.06.2025.
//

import SwiftUI

struct FavoritesView: View {
    @Bindable var viewModel: NewsViewModel
    var body: some View {
        
        NavigationStack {
            VStack {
                if !viewModel.currentUser.favoriteArticles.isEmpty {
                    ListOfNews(currentUser: viewModel.currentUser, articles: viewModel.currentUser.favoriteArticles, onFavorite: { article in
                        viewModel.currentUser.addToFavorites(article: article)
                    })
                }
                else {
                    ContentUnavailableView {
                        Label("No favorite news yet", systemImage: "tray.fill")
                    } description: {
                        Text("News you like will appear here.")
                    }
                }
                
            }
            .navigationTitle("Favorites")
        }
        
    }
    
}


     
