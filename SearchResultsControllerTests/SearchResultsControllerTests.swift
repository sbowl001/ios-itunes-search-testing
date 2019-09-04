//
//  SearchResultsControllerTests.swift
//  SearchResultsControllerTests
//
//  Created by Stephanie Bowles on 9/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import XCTest
@testable import iTunes_Search

class SearchResultsControllerTests: XCTestCase {

     //does decoding work?
    //does decoding fail when given bad data?
    //does it build the correct url?
    //does it build the correct url request?
    //are the results saved properly?
    //is the completion handler called if the networking fails?
    //is the completion handler called if the data is bad?
    //is the completion handler called if the data is good?
    
    
    func testForSomeResults(){
        let mock = MockDataLoader()
        mock.data = goodResultsData
        
        let controller = SearchResultController(dataLoader: mock)
        
        let resultsExpection = expectation(description: "Wait for results")
        
        controller.performSearch(for: "Garage Band", resultType: .software) {
            
            resultsExpection.fulfill()
        }
        
        wait(for: [resultsExpection], timeout: 2)
        //Now check results
        XCTAssertTrue(controller.searchResults.count == 2, "Expecting 2 results for garage band")
        XCTAssertEqual("GarageBand", controller.searchResults[0].title)
        XCTAssertEqual("Apple", controller.searchResults[0].artist)
    }
    
    func testBadResultData(){
        let mock = MockDataLoader()
        mock.data = badResultsData
        let controller = SearchResultController(dataLoader: mock)
        let resultsExpectation = expectation(description: "wait for search results")
        controller.performSearch(for: "GarageBand", resultType: .software) {
            resultsExpectation.fulfill()
        }
        wait(for: [resultsExpectation], timeout: 2)
        XCTAssertTrue(controller.searchResults.count == 0, "Expecting no results for GarageBand using bad data")
        XCTAssertNotNil(controller.error)
    }
    
    func testNoResults(){
        let mock = MockDataLoader()
        mock.data = noResultsData
        let controller = SearchResultController(dataLoader: mock)
        let resultsExpectation = expectation(description: "wait for search results")
        controller.performSearch(for: "GarageBand", resultType: .software) {
            resultsExpectation.fulfill()
        }
        wait(for: [resultsExpectation], timeout: 2)
        XCTAssertTrue(controller.searchResults.count == 0, "Expecting no results for GarageBand using bad data")
        XCTAssertNil(controller.error)
    }


}
