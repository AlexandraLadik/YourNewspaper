//
//  ListOfNews.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 14.06.2025.
//

import SwiftUI

struct ListOfNews: View {
        var currentUser: Profile
        let articles: [News.Article]
        var onFavorite: (News.Article) -> Void
        @Bindable var favVM: FavouritesViewModel
           var body: some View {
               List {
                   ForEach(articles, id: \.description) { article in
                       ZStack {
                           NavigationLink {
                               ArticleFullView(arcticle: article, currentUser: currentUser, favVM: favVM)
                           } label: {
                               EmptyView()
                           }
                           .opacity(0)
                           
                           ArticleCell(article: article)
                               .frame(maxWidth: .infinity, alignment: .leading)
                       }
                       .listRowInsets(EdgeInsets())
                       .swipeActions {
                           withAnimation {
                               Button {
                                   onFavorite(article)
                               } label: {
                                   Label("Favorite", systemImage: "star")
                                   
                               }
                               .tint(favVM.favoriteArticles.contains(where: { $0.title == article.title}) ? .yellow : .accentColor)
                           }
                       }
                   }
               }
               .listStyle(.plain)
               .scrollIndicators(.hidden)
           }
       

}
