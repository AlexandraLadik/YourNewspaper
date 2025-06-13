//
//  ArticleFullView.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 23.02.2025.
//

import SwiftUI

struct ArticleFullView: View {
    var arcticle: News.Article
    var currentUser: Profile
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(arcticle.title)
                            .font(.newsTitle)
                            .multilineTextAlignment(.center)
                            .padding()
                            .padding(.horizontal, 20)
                        Button {
                            currentUser.addToFavorites(article: arcticle)
                        } label: {
                            Image(systemName: currentUser.favoriteArticles.contains(where: { $0.title == arcticle.title}) ? "star.fill" : "star")
                                .tint(.yellow)
                        }
                    }
                    
                    if let urlString = arcticle.urlToImage, let url = URL(string: urlString) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity)
                                .clipShape(RoundedRectangle(cornerRadius: 19.0))
                        } placeholder: {
                            PhotoPlaceholder()
                        }
                    } else {
                        PhotoPlaceholder()
                    }
                }.padding(.vertical, 10)
              
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text(arcticle.content ?? "")
                        .font(.newsText)
                        
                    Text(arcticle.description ?? "")
                        .font(.newsText)
                        
                }
                Spacer()
                Text(arcticle.source.name)
                    .font(.newsResourceFootnote)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    
            }
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
       
    }
}

