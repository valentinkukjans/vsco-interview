//
//  SearchRepositoryTests.swift
//  VSCOInterviewTests
//
//  Created by Valentins Kukjans on 11/13/22.
//

import XCTest
@testable import VSCOInterview

class SearchRepositoryTests: XCTestCase {
    var sut: SearchRepository!
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFetchError()  {
        // Given
        sut = SearchRepository(service: SearchServiceMock(searchResult: nil))
        
        // When
        Task {
            do {
                try await sut.fetch(with: SearchQuery(text: "ggg", page: 5))
                XCTFail("Should return error")
            } catch {
                // Then
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testFetchSuccess() {
        // Given
        let searchResult = SearchResult(page: 4, pages: 5451, total: 234, posts: [Post(title: "foo", imageUrl: "some/path")])
        sut = SearchRepository(service: SearchServiceMock(searchResult: searchResult))
        
        // When
        Task {
            let result = try await sut.fetch(with: SearchQuery(text: "ggg", page: 5))
            // Then
            XCTAssertEqual(result, searchResult)
        }
    }
}
