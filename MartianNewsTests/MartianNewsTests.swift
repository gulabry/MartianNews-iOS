//
//  MartianNewsTests.swift
//  MartianNewsTests
//
//  Created by Bryan Gula on 10/22/18.
//  Copyright © 2018 Gula, Inc. All rights reserved.
//

import XCTest
@testable import MartianNews

class MartianNewsTests: XCTestCase {
    
    //  Downloads and parsed Articles plist from NY Times endpoint
    //
    func testArticleDownloadAndParsing() {
        
        let expectation = XCTestExpectation(description: "Download NY Times Articles")
        
        API.get { articles in
            
            XCTAssertNotNil(articles, "Articles were nil.")
            
            assert((articles as Any) is [Article], "Articles are downloaded and parsed.")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }

    func testMartianStringConversionFullExample() {
        
        let expectedResult = "boinga boinga boinga boinga boinga"
        
        let title = Translator.toMartian(from: "every word should need conversion")
        
        XCTAssertEqual(title, expectedResult, "String conversion method failed to convert")
    }
    
    func testMartianStringConversionPartialExample() {
        
        let expectedResult = "boinga 2 boinga boinga be boinga"
        
        let title = Translator.toMartian(from: "only 2 words shouldn't be converted")
        
        XCTAssertEqual(title, expectedResult, "String conversion method failed to convert")
    }
    
    func testMartianStringConversionPunctuationExample() {
        
        let expectedResult = "boinga 1 `boinga` boinga boinga boinga"
        
        let title = Translator.toMartian(from: "only 1 `word` should keep punctuation")
        
        XCTAssertEqual(title, expectedResult, "String conversion method failed to convert")
    }
}
