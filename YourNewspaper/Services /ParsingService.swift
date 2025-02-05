//
//  ParsingService.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 23.02.2025.
//

import Foundation

class ParsingService {
    static let shared = ParsingService(); private init() { }
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    func parse<T: Decodable>(type: T.Type, data: Data) -> T? {
        let parsed = try? decoder.decode(type, from: data)
        return parsed 
    }
}
