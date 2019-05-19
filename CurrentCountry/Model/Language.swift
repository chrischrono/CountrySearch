//
//  Language.swift
//  CountrySearch
//
//  Created by Christian  Huang on 17/11/18.
//  Copyright © 2018 Christian Huang. All rights reserved.
//

import Foundation


class Language: Codable {
    var name: String
    var iso639_1: String?
    var iso639_2: String?
    var nativeName: String?
}
