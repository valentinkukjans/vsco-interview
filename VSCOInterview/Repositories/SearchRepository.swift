//
//  SearchRepository.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import Foundation

struct SearchRepository: SearchRepositoryProtocol {
    private var service: SearchServiceProtocol

    // MARK: - Initialization

    init(service: SearchServiceProtocol = SearchService()) {
        self.service = service
    }

    // MARK: - Public methods
   @discardableResult
    func fetch(with searchQuery: SearchQuery) async throws -> SearchResult {
        try await service.fetch(with: searchQuery)
    }
}
