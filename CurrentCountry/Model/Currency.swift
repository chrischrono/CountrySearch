//
//  Currency.swift
//  CountrySearch
//
//  Created by Christian  Huang on 17/11/18.
//  Copyright © 2018 Christian Huang. All rights reserved.
//

import Foundation


class Currency: Codable {
    var code: String?
    var name: String?
    var symbol: String?
    
    /**
     Convert currency data String
     - return String?:
            nil -> if all the currency data is nil
            "<name/code> - <symbol>" -> expected result
     */
    func toString() -> String? {
        var result = ""
        
        result = name ?? code ?? ""
        if let symbol = self.symbol {
            if result.count > 0 {
                result += " - "
            }
            result += symbol
        }
        
        return result.count > 0 ? result : nil
    }
}
