//
//  Country.swift
//  CountrySearch
//
//  Created by Christian  Huang on 17/11/18.
//  Copyright © 2018 Christian Huang. All rights reserved.
//

import Foundation

class Country: Codable {
    var name: String
    var alpha2Code: String
    var alpha3Code: String
    var capital: String
    var region: String
    var subregion: String
    var population: Int
    var latlng: [Double]
    var demonym: String
    var area: Double?
    var gini: Float?
    var timezones: [String]
    var nativeName: String
    var numericCode: String?
    var currencies: [Currency]
    var languages: [Language]
    //var translations: [String: String]
    var flag: String
    var regionalBlocs: [RegionalBloc]
    var cioc: String?
}
