//
//  MockNetworkManager.swift
//  CountrySearchTests
//
//  Created by Christian on 19/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import Foundation
@testable import CountrySearch


class MockNetworkManager: RESTCountriesAPINetworkProtocol {
    var mockCountries: [Country]?
    var mockError: String?
    
    required init(environment: NetworkEnvironment) {
    }
    
    func fetchCountries(completion: @escaping (_ countries: [Country]?,_ error: String?) -> ()) {
        completion(mockCountries, mockError)
    }
    
    
}
