//
//  News.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 23.02.2025.
//


import Foundation

struct News: Codable {
    var status: String
    var totalResults: Int
    var articles: [Article]
 
    struct Article: Codable {
        let source: Source
        let author: String?
        let title: String
        let description: String?
        let url: String
        let urlToImage: String?
        let publishedAt: String
        let content: String?
 
    }
  
    
    struct Source: Codable {
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
extension News.Source {
    var representation: [String: Any] {
        var represent = [String: Any]()
        represent["name"] = name
        represent["id"] = id
        return represent
    }
}
extension News.Article {
    var representation: [String: Any] {
        var represent = [String: Any]()
        represent["source"] = source.representation
        represent["author"] = author
        represent["title"] = title
        represent["description"] = description
        represent["url"] = url
        represent["urlToImage"] = urlToImage
        represent["publishedAt"] = publishedAt
        represent["content"] = content
        return represent
    }
}


extension News.Article {
    init?(_ data: [String: Any]) {
       
        guard let sourceDict = data["source"] as? [String: Any],
              let sourceName = sourceDict["name"] as? String
        else { return nil }
        
        
        let source = News.Source(name: sourceName, id: sourceDict["id"] as? String)
        
  
        guard let author = data["author"] as? String,
              let title = data["title"] as? String,
              let description = data["description"] as? String,
              let url = data["url"] as? String,
              let urlToImage = data["urlToImage"] as? String,
              let publishedAt = data["publishedAt"] as? String,
              let content = data["content"] as? String
                
        else { return nil }
        

        self.init(
            source: source,
            author: author,
            title: title,
            description: description,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publishedAt,
            content: content
        )
    }
}
