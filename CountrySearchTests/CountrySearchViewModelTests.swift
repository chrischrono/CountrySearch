//
//  CountrySearchViewModelTests.swift
//  CountrySearchTests
//
//  Created by Christian on 19/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import XCTest
import CoreLocation
@testable import CountrySearch

class CountrySearchViewModelTests: XCTestCase {
    
    
    private let networkManager = MockNetworkManager(environment: .qa)
    private let locationManager = MockLocationManager()
    private let countrySearchViewModel = CountrySearchViewModel()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        locationManager.mockLocation = CLLocation(latitude: 56, longitude: 10)
        let placemark = MockPlacemark()
        placemark.mockisoCountryCode = "DE"
        locationManager.mockPlacemark = placemark
        countrySearchViewModel.locationManager = locationManager
        countrySearchViewModel.networkManager = networkManager
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testFetchCountriesError() {
        
        networkManager.mockError = "This is an error"
        networkManager.mockCountries = nil
        
        countrySearchViewModel.getCurrentLocation()
        
        XCTAssertEqual(countrySearchViewModel.status.value, networkManager.mockError?.localized())
    }
    
    func testFetchCountries() {
        
        let data = loadDataFromBundle(withName: "countries", extension: "json")
        let countries = try! JSONDecoder().decode([Country].self, from: data)
        networkManager.mockCountries = countries
        networkManager.mockError = nil
        
        countrySearchViewModel.keyword = ""
        countrySearchViewModel.getCurrentLocation()
        
        XCTAssertEqual(countrySearchViewModel.getFilteredCountryCount(), 250)
    }
    
    func testFilterCountries() {
        
        let data = loadDataFromBundle(withName: "countries", extension: "json")
        let countries = try! JSONDecoder().decode([Country].self, from: data)
        networkManager.mockCountries = countries
        networkManager.mockError = nil
        
        countrySearchViewModel.keyword = ""
        countrySearchViewModel.getCurrentLocation()
        
        let keywords = ["Den", "english", "jak"]
        let results = [3, 91, 1]
        
        for i in 0..<keywords.count {
            countrySearchViewModel.keyword = keywords[i]
            XCTAssertEqual(countrySearchViewModel.getFilteredCountryCount(), results[i])
        }
    }

}
