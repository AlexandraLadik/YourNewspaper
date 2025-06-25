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
    var body: some View {
        NavigationStack {
            if let articles = viewModel.news?.articles {
                ListOfNews(currentUser: viewModel.currentUser, articles: articles,
                            onFavorite: { article in  
                    viewModel.currentUser.addToFavorites(article: article)
                                })
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
                
                
                
            }
            
            
            else { ProgressView("Loading news...")
                    }
            }
        .onChange(of: selectedCounty) {
            Task {
                viewModel.fetchDatabyCountry(country: selectedCounty)
            }
        }
    }
    
}

