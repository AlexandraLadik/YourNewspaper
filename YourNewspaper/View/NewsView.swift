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
    @Bindable var coordinator: Coordinator
    
    var body: some View {
        NavigationStack {
            if let articles = viewModel.news?.articles {
                InterestsScrollView(interestsVM: settingsVM, viewModel: viewModel)
                ListOfNews(currentUser: viewModel.profile, articles: articles,
                           onFavorite: { article in
                    viewModel.profile.addToFavorites(article: article)
                               })
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


#Preview {
    NewsView(viewModel: .init(userID: ""), isPresented: false, settingsVM: .init(userID: ""), coordinator: .init())
}
