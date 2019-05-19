//
//  File.swift
//  CountrySearch
//
//  Created by Christian on 19/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import Foundation


class CountryDetailViewModel {
    private var country: Country?
    
    var flag: String {
        return "http://flagpedia.net/data/flags/normal/\(country?.alpha2Code.lowercased() ?? "").png"
    }
    var name: String {
        return country?.name ?? ""
    }
    var population: Int {
        return country?.population ?? 0
    }
    var capital: String {
        return country?.name ?? ""
    }
    var region: String {
        return country?.region ?? ""
    }
    var regionalBlocs: String {
        guard let country = country else {
            return ""
        }
        let blocs = country.regionalBlocs.map({ $0.acronym })
        return blocs.joined(separator: ",")
    }
    var language: String {
        guard let country = country else {
            return ""
        }
        let languages = country.languages.map({ $0.name })
        return languages.joined(separator: ",")
    }
    var currency: String {
        guard let country = country else {
            return ""
        }
        let currencies = country.currencies.compactMap({ $0.toString() })
        return currencies.joined(separator: ",")
    }
    
}

//MARK:- public func
extension CountryDetailViewModel {
    func setCountryDetail(_ country: Country) {
        self.country = country
    }
}
