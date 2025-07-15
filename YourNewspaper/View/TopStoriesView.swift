//
//  TopStoriesView.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 29.04.2025.
//

import SwiftUI

struct TopStoriesView: View {
    @State var viewModel: TopStoriesViewModel
    @State private var selectedCounty: String = "United States"
    @Environment(Profile.self) var profile
    @Bindable var favVM: FavouritesViewModel
    var body: some View {
        NavigationStack {
            if let articles = viewModel.news?.articles {
                ListOfNews(currentUser: profile, articles: articles,
                           onFavorite: { article in
                    favVM.toggleFavorite(article: article)
                }, favVM: favVM)
                           
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Top Stories").font(.newsTitle)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        
                        Picker("", selection: $selectedCounty) {
                            ForEach(viewModel.allCountries, id: \.self) { country in
                                Text(country).tag(country)
                            }
                        }
                    }
                }
            } else { ProgressView("Loading news...") }
            }
        .onChange(of: selectedCounty) {
            Task {
                viewModel.fetchDatabyCountry(country: selectedCounty)
            }
        }
    }
    
}

