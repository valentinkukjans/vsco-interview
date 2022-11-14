//
//  SearchServiceMock.swift
//  VSCOInterviewTests
//
//  Created by Valentins Kukjans on 11/14/22.
//

import Foundation
@testable import VSCOInterview

struct SearchServiceMock: SearchServiceProtocol {

    let searchResult: SearchResult?

    private let result: (SearchResult?) async throws -> SearchResult = { searchResult in
        if searchResult == nil {
            throw ServiceError.invalidRequest
        } else {
            return searchResult!
        }
    }

    func fetch(with searchQuery: SearchQuery) async throws -> SearchResult {
        try await result(searchResult)
    }
}
