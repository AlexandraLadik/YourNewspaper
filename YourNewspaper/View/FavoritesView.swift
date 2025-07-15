//
//  FavoritesView.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 14.06.2025.
//

import SwiftUI

struct FavoritesView: View {
    @State var viewModel: FavouritesViewModel
    @Environment(Profile.self) var profile
    var body: some View {
        NavigationStack {
            VStack {
                if !viewModel.favoriteArticles.isEmpty {
                    ListOfNews(currentUser: profile, articles: viewModel.favoriteArticles,
                               onFavorite: { article in
                        viewModel.toggleFavorite(article: article)
                    }, favVM: viewModel)
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


     
