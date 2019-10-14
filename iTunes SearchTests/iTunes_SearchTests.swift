//
//  iTunes_SearchTests.swift
//  iTunes SearchTests
//
//  Created by Mitchell Budge on 10/14/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import XCTest
@testable import iTunes_Search

class iTunes_SearchTests: XCTestCase {

    func testForSomeResult() {
        let controller = SearchResultController()
        let resultsExpectation = expectation(description: "Wait for results")
        
        controller.performSearch(for: "GarageBand", resultType: .software) {
            resultsExpectation.fulfill()
        }
        wait(for: [resultsExpectation], timeout: 2)
        
        XCTAssertTrue(controller.searchResults.count > 0, "Expecting at least one result for GarageBand")
    }
   
}
