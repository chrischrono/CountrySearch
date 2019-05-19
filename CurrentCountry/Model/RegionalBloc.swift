//
//  RegionalBloc.swift
//  CountrySearch
//
//  Created by Christian  Huang on 17/11/18.
//  Copyright © 2018 Christian Huang. All rights reserved.
//

import Foundation


class RegionalBloc: Codable {
    var acronym: String
    var name: String
    var otherAcronyms: [String]
    var otherNames: [String]
}
