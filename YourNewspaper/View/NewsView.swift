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
    @State var settingsVM = UserSettingsViewModel()
    
    var body: some View {
        NavigationStack {
            InterestsScrollView(viewModel: viewModel)
            if let articles = viewModel.news?.articles {
                ScrollView {
                    ForEach (articles, id: \.title) {
                        article in
                        NavigationLink {
                            ArticleFullView(arcticle: article)
                        } label : {
                            ArticleCell(article: article)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .fullScreenCover(isPresented: $isPresented) {
                    UserSettingsView(viewModel: settingsVM)
                    }
                .scrollIndicators(.hidden)
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

       
    
