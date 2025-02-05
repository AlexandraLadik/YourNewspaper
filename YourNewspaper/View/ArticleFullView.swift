//
//  ArticleFullView.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 23.02.2025.
//

import SwiftUI

struct ArticleFullView: View {
    var arcticle: News.Article
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text(arcticle.title)
                        .font(.newsTitle)
                        .multilineTextAlignment(.center)
                        .padding()
                        
                    
                    AsyncImage(url: arcticle.urlToImage) {
                        image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 19.0))
                            
                    } placeholder: { }
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
