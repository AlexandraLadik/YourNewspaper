//
//  News.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 23.02.2025.
//

import Foundation

struct News: Decodable {
    var status: String
    var totalResults: Int
    var articles: [Article]
 
    struct Article: Decodable {
        let source: Source
        let author: String?
        let title: String
        let description: String?
        let url: String?
        let urlToImage: String?
        let publishedAt: String
        let content: String?
 
    }
    struct Source: Decodable {
        let name: String
        let id: String?
    }
}


extension News.Article {

    func formattedPublishedDate(from dateString: String) -> String {
        
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]
        
        guard let date = isoFormatter.date(from: dateString) else {
            return "Некорректная дата"
        }
        
        let now = Date()
        let diff = Calendar.current.dateComponents([.hour], from: date, to: now)
        
        if let hours = diff.hour, hours >= 24 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM yyyy, HH:mm"
            return dateFormatter.string(from: date)
        } else {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .short
            formatter.locale = Locale(identifier: "ru_RU")
            return formatter.localizedString(for: date, relativeTo: now)
        }
    }
}




