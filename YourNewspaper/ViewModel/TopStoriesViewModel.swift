//
//  TopStoriesViewModel.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 29.04.2025.
//


import Foundation


@Observable
final class TopStoriesViewModel {
    var news: News?
    var allCountries: [String] = []
    
    init() {
           
        allCountries = getAllCountries()
        fetchDatabyCountry(country: "united states")
    }
    
    func countryNameToISOCode(_ countryName: String) -> String? {
        let locale = Locale(identifier: "en_US")

        for region in Locale.Region.isoRegions {
            let code = region.identifier
            if let name = locale.localizedString(forRegionCode: code),
               name.lowercased() == countryName.lowercased() {
                return code
            }
        }

        return nil
    }
    func getAllCountries(locale: Locale = Locale(identifier: "en_US")) -> [String] {
        return Locale.Region.isoRegions.compactMap { region in
            let code = region.identifier
            if let name = locale.localizedString(forRegionCode: code) {
                return name
            } else {
                return nil
            }
        }.sorted()
    }
    
    func fetchDatabyCountry(country: String) {
        
            let isoCountry = countryNameToISOCode(country)
            Task {
                let news = try await NetworkService.shared.fetchSearchCountry(country: isoCountry ?? "us")
                await MainActor.run {
                    self.news = news
                }
            }
        
    }
    
   
}
