//
//  SearchServiceTests.swift
//  VSCOInterviewTests
//
//  Created by Valentins Kukjans on 11/13/22.
//

import XCTest
import Foundation
@testable import VSCOInterview

class SearchServiceTests: XCTestCase {
    private var searchQuery = SearchQuery(text: "foo", page: 1)
    private var searchEndpoint: SearchEndpoint!

    override func setUp() {
        super.setUp()
        searchEndpoint = .search(searchQuery)
    }

    override func tearDown() {
        searchEndpoint = nil
        super.tearDown()
    }

    func testSearchServiceFailure() {
        // Given
        URLProtocolMock.testURLs = [nil: Data()]

        Task {
            do {
                // When
                _ = try await SearchService().fetch(with: self.searchQuery)
                XCTFail("Search qequest should fail")
            } catch {
                // Then
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testSearchServiceSuccess() {
        // Given
        URLProtocolMock.testURLs = ["foo": TestUtils.getJsonData(forResource: "SearchResults", ofType: "json")]

        Task {
            do {
                // When
                let result = try await SearchService().fetch(with: self.searchQuery)
                
                // Then
                XCTAssertNotNil(result.posts)
                XCTAssertEqual(result.posts.count, 100)
                XCTAssertEqual(result.posts.last?.title, "Flowers")
                XCTAssertEqual(result.posts.last?.imageUrl, "https://live.staticflickr.com/65535/52496948077_d3815673e8_m.jpg")
                XCTAssertEqual(result.posts.first?.title, "yellow flower")
                XCTAssertEqual(result.posts.first?.imageUrl, "https://live.staticflickr.com/65535/52498189095_e53c361810_m.jpg")
            } catch {
                XCTFail("Search qequest should succeed")
            }
        }
    }
}
