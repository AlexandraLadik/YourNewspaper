//
//  NewsView.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 23.02.2025.
//

import SwiftUI

struct NewsView: View {
    @State var viewModel: NewsViewModel
    @State var isPresented: Bool = false
    @State var settingsVM: UserSettingsViewModel
    @Bindable var favVM: FavouritesViewModel
    @Environment(Coordinator.self) var coordinator: Coordinator
    @Environment(Profile.self) var profile
    
    var body: some View {
        NavigationStack {
            if let articles = viewModel.news?.articles {
                InterestsScrollView(interestsVM: settingsVM, viewModel: viewModel)
                ListOfNews(currentUser: profile, articles: articles,
                           onFavorite: { article in
                    favVM.toggleFavorite(article: article)
                }, favVM: favVM)
                .fullScreenCover(isPresented: $isPresented) {
                    UserSettingsView(viewModel: settingsVM, coordinator: coordinator)
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
      
        .searchable(text: $viewModel.searchtext, placement:
                .navigationBarDrawer(displayMode: .always))
        .font(.newsText)
        .onChange(of: viewModel.searchtext) {
            viewModel.fetchDatabyWord(searchWord: viewModel.searchtext)
        }
       
        }
    
    }
