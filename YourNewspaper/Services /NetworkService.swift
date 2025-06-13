//
//  NetworkService.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 23.02.2025.
//

import Foundation

class NetworkService {
    static let shared = NetworkService(); private init() { }
    private let session = URLSession.shared
    
    func fetchNews() async throws -> News {
        guard let url = URLManager.shared.createURL(endpoint: .topHeadlines(country: "us")) else { throw NetworkError.badURL }
        print("🌐 URL: \(url)")
            let (data, response) = try await session.data(from: url)
        guard (response as! HTTPURLResponse).statusCode == 200 else { throw NetworkError.badResponse }
        if let httpResponse = response as? HTTPURLResponse {
            print("📥 Status code: \(httpResponse.statusCode)")
        }
            guard let news = ParsingService.shared.parse(type: News.self,
                                                          data: data) else { print("❌ Failed to parse. Raw data:")
                print(String(data: data, encoding: .utf8) ?? "nil") ; throw NetworkError.invalidData}
        return news
          
        }
    func fetchSearchNews(searchWord: String) async throws -> News {
        guard let url = URLManager.shared.createURL(endpoint: .search(word: searchWord)) else { throw NetworkError.badURL }
        let (data, response) = try await session.data(from: url)
        guard (response as! HTTPURLResponse).statusCode == 200 else { throw NetworkError.badResponse }
        guard let news = ParsingService.shared.parse(type: News.self, data: data) else {
            throw NetworkError.invalidData
        }
        return news
     }
    
    func fetchSearchCountry(country: String) async throws -> News {
        guard let url = URLManager.shared.createURL(endpoint: .topHeadlines(country: country)) else { throw NetworkError.badURL }
        let (data, response) = try await session.data(from: url)
        guard (response as! HTTPURLResponse).statusCode == 200 else { throw NetworkError.badResponse }
        guard let news = ParsingService.shared.parse(type: News.self, data: data) else {
            throw NetworkError.invalidData
        }
        return news
     }
    
}

enum NetworkError: Error, CustomStringConvertible {
    case badURL
    case badRequest
    case badResponse
    case invalidData
    
    var description: String {
        switch self {
        case .badURL:
            "неправильный URL"
        case .badRequest:
            "проблемы с запросом"
        case .badResponse:
            "проблемы с ответом"
        case .invalidData:
            "проблемы с данными"
        }
        }
    }

