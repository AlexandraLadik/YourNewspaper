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
                AsyncImage(url: article.urlToImage) {
                    image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 358, height: 201)
                        .clipShape(RoundedRectangle(cornerRadius: 12.0))
                } placeholder: {
                    Image(systemName: "photo")
                        .foregroundStyle(.secondary)
                        .frame(width: 358, height: 201)
                        .background(Color.clear)
                        .clipShape(RoundedRectangle(cornerRadius: 12.0))
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
       
    
    
    

