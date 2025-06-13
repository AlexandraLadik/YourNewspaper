//
//  ArticleCell.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 25.02.2025.
//

import SwiftUI

struct ArticleCell: View {
    var article: News.Article
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 0) {
            VStack {
                if let urlString = article.urlToImage, let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 358, height: 201)
                            .clipShape(RoundedRectangle(cornerRadius: 12.0))
                    } placeholder: {
                        Image(systemName: "photo")
                            .foregroundStyle(.secondary)
                            .frame(width: 358, height: 201)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 12.0))
                    }
                } else {
                    PhotoPlaceholder()
                }
            }
            .padding()
            
            VStack (alignment: .leading, spacing: 13) {
                Text (article.title)
                    .font(.newsTitle)
                    .tint(.black)
                    .multilineTextAlignment(.leading)
                HStack {
                    Text(article.source.name)
                    Spacer()
                    Text("\(article.formattedPublishedDate(from: article.publishedAt))")
                        .padding(20)
                }
                .font(.newsResourceFootnote)
                .tint(.customBlue)
                
            }
            .padding(.horizontal)
            
        }
        
       
        
            }
        }
       
    
    
    

