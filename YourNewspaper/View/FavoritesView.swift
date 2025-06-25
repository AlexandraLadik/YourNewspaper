//
//  FavoritesView.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 14.06.2025.
//

import SwiftUI

struct FavoritesView: View {
    @State var viewModel: NewsViewModel
    var body: some View {
        NavigationStack {
            VStack {
                if !viewModel.favoriteArticles.isEmpty {
                    ForEach(viewModel.favoriteArticles, id: \.url) { article in
                        ListOfNews(currentUser: viewModel.profile, articles: viewModel.favoriteArticles, onFavorite: { article in
                            viewModel.profile.addToFavorites(article: article)
                                        })
                    }
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


     
