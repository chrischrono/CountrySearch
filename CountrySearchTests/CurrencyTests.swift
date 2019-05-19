//
//  CurrencyTests.swift
//  CountrySearchTests
//
//  Created by Christian on 19/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import XCTest
@testable import CountrySearch

class CurrencyTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testCurrencyToString() {
        var currency = Currency()
        XCTAssertNil(currency.toString())
        
        let currencies: [(String?, String?, String?)] = [(nil, nil, nil),
                                                         ("EUR", "Euro", "€"),
                                                         ("EUR", nil, "€"),
                                                         (nil, "Euro", nil),
                                                         ("EUR", nil, nil),
                                                         (nil, nil, "€")]
        let results: [String?] = [nil, "Euro - €", "EUR - €", "Euro", "EUR", "€"]
        
        for i in 0..<currencies.count {
            let data = currencies[i]
            currency.code = data.0
            currency.name = data.1
            currency.symbol = data.2
            XCTAssertEqual(currency.toString(), results[i])
        }
    }

}
