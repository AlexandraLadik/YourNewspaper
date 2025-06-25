//
//  URLManager.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 23.02.2025.
//

import Foundation

class URLManager {
    static let shared = URLManager(); private init() { }
    private let httpGateway: Gateway = .https
    private let server: Server = .develop
    private let apiKey = "&apiKey=ec5878ddd93840e48f84296210042520"
    
    func createURL(endpoint: Endpoint) -> URL? {
        let urlStr = httpGateway.rawValue + server.rawValue + endpoint.description + apiKey
        print(urlStr)
        return URL(string: urlStr)
    }
}

enum Gateway: String {
    case http = "http://"
    case https = "https://"
}

enum Server: String {
    case develop = "newsapi.org/v2"
}

enum Endpoint: CustomStringConvertible {
    case everything
    case topHeadlines(country: String)
    case search(word: String)
    case categories(category: String)
    
    var description: String {
        switch self {
        case .everything:
            "/everything"
        case .topHeadlines(country: let country):
            "/top-headlines?country=\(country)"
        case .search(word: let word):
            "/everything?q=\(word)"
        case .categories(category: let category):
            "/top-headlines/sources?category=\(category)"
        }
        
    }
}


