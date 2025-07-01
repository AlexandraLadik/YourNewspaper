//
//  FavoritesView.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 14.06.2025.
//

import SwiftUI

struct FavoritesView: View {
    @State var viewModel: FavouritesViewModel
    var body: some View {
        NavigationStack {
            VStack {
                if !viewModel.profile.favoriteArticles.isEmpty {
                        ListOfNews(currentUser: viewModel.profile, articles: viewModel.profile.favoriteArticles, onFavorite: { article in
                            viewModel.profile.addToFavorites(article: article)  })
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


     
