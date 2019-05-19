//
//  TodayViewModel.swift
//  CurrentCountry
//
//  Created by Christian on 19/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import Foundation


class TodayViewModel {
    private var country: Country? {
        didSet {
            configureViewClosure?()
        }
    }
    
    var flag: String {
        return "http://flagpedia.net/data/flags/normal/\(country?.alpha2Code.lowercased() ?? "").png"
    }
    var name: String {
        return country?.name ?? " "
    }
    var population: Int {
        return country?.population ?? 0
    }
    var capital: String {
        return country?.capital ?? " "
    }
    var region: String {
        return country?.region ?? " "
    }
    var regionalBlocs: String {
        guard let country = country else {
            return " "
        }
        let blocs = country.regionalBlocs.map({ $0.acronym })
        return blocs.joined(separator: ",")
    }
    var language: String {
        guard let country = country else {
            return " "
        }
        let languages = country.languages.map({ $0.name })
        return languages.joined(separator: ",")
    }
    var currency: String {
        guard let country = country else {
            return " "
        }
        let currencies = country.currencies.compactMap({ $0.toString() })
        return currencies.joined(separator: ",")
    }
    
    var configureViewClosure: (()->())?
    
    func updateCountry() -> Bool {
        let sharedDefaults = UserDefaults.init(suiteName: "group.CountrySearchSharing")
        
        if let jsonString = sharedDefaults?.value(forKey: "currentCountry") as? String, let jsonData = jsonString.data(using: .utf8) {
            if let country = try? JSONDecoder().decode(Country.self, from: jsonData) {
                self.country = country
                return true
            }
        }
        return false
    }
    
}
