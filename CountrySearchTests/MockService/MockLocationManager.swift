//
//  MockLocationManager.swift
//  CountrySearchTests
//
//  Created by Christian on 19/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import Foundation
import CoreLocation
@testable import CountrySearch

class MockPlacemark: CLPlacemark {
    var mockisoCountryCode: String?
    
    override var isoCountryCode: String? {
        return mockisoCountryCode
    }
}

class MockLocationManager: LocationManagerProtocol {
    
    var mockLocation: CLLocation?
    var mockPlacemark: MockPlacemark?
    var locationUpdateClosure: ((CLLocation?, CLPlacemark?)->())?
    
    func requestLocation(placemarkNeeded: Bool) {
        locationUpdateClosure?(mockLocation, mockPlacemark)
    }
}
