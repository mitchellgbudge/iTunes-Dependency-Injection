//
//  SearchResultControllerTests.swift
//  SearchResultControllerTests
//
//  Created by Johnny Hicks on 9/3/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import XCTest
@testable import iTunes_Search

class SearchResultControllerTests: XCTestCase {

    /**
     Does decoding work?
     Does decoding fail when given bad data?
     Does it build the correct URL?
     Does it build the correct URL Request?
     Are the results saved properly?
     Is the completion handler called if the networking fails?
     Is the completion handler called if the data is bad?
     Is the completion handler called if the data is good?
     */
    
    func testForSomeResults() {
        let mock = MockDataLoader()
        mock.data = goodResultData
        let controller = SearchResultController(dataLoader: mock)
        
        let resultsExpection = expectation(description: "Wait for results")
        
        controller.performSearch(for: "Garage Band", resultType: .software) {
            resultsExpection.fulfill()
        }
        
        wait(for: [resultsExpection], timeout: 2)
        // Now check results
        XCTAssertTrue(controller.searchResults.count == 2, "Expecting 2 results for GarageBand")
        XCTAssertEqual("GarageBand", controller.searchResults[0].title)
        XCTAssertEqual("Apple", controller.searchResults[0].artist)
    }
    
    func testBadResultData() {
        let mock = MockDataLoader()
        mock.data = badResultData
        let controller = SearchResultController(dataLoader: mock)
        let resultsExpectation = expectation(description: "Wait for search results")
        controller.performSearch(for: "GarageBand", resultType: .software) {
            resultsExpectation.fulfill()
        }
        
        wait(for: [resultsExpectation], timeout: 2)
        XCTAssertTrue(controller.searchResults.count == 0, "Expecting no results for GarageBand using bad data")
        XCTAssertNotNil(controller.error)
    }
    
    func testNoResults() {
        let mock = MockDataLoader()
        mock.data = noResultsData
        let controller = SearchResultController(dataLoader: mock)
        let resultsExpectation = expectation(description: "Wait for search results")
        controller.performSearch(for: "abcdefg123", resultType: .software) {
            resultsExpectation.fulfill()
        }
        
        wait(for: [resultsExpectation], timeout: 2)
        XCTAssertTrue(controller.searchResults.count == 0, "Expecting no results for abcdefg123Help")
        XCTAssertNil(controller.error)
    }

}
