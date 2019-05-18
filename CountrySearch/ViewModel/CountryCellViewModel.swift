//
//  CountryCellViewModel.swift
//  CountrySearch
//
//  Created by Christian on 12/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import Foundation


class CountryCellViewModel {
    let name: String
    let capital: String
    let languages: String
    let flag: String
    let population: Int
    let area: Double?
    var distance: Double = 0
    
    init(with country: Country) {
        name = country.name
        capital = country.capital
        languages = country.languages.map({ (language) -> String in
            return language.name
        }).joined(separator: ",")
        flag = "http://flagpedia.net/data/flags/normal/\(country.alpha2Code.lowercased()).png"
        population = country.population
        area = country.area
    }
}
