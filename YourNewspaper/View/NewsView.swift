//
//  NewsView.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 23.02.2025.
//

import SwiftUI

struct NewsView: View {
    @State var searchText: String = ""
    @State var viewModel: NewsViewModel
    @State var isPresented: Bool = false
    @State var settingsVM: UserSettingsViewModel
    
    var body: some View {
        NavigationStack {
            if let articles = viewModel.news?.articles {
                InterestsScrollView(interestsVM: settingsVM, viewModel: viewModel)
                ListOfNews(currentUser: viewModel.currentUser, articles: articles,
                           onFavorite: { article in
                                   viewModel.currentUser.addToFavorites(article: article)
                               })
                .fullScreenCover(isPresented: $isPresented) {
                    UserSettingsView(viewModel: settingsVM, coordinator: .init())
                    }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("News").font(.newsTitle)
                        
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("", systemImage: "gearshape") {
                            isPresented = true
                        }
                        .tint(.black)
                    }
                }
            } else { ProgressView("Loading news...") }
            
        }
      
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .font(.newsText)
        .onChange(of: searchText) {
            viewModel.fetchDatabyWord(searchWord: searchText)
        }
       
        }
    
    }


