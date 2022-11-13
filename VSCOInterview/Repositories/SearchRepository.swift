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

    func fetch(with query: String, page: Int) async throws -> SearchResult {
        try await service.fetch(with: query, page: page)
    }
}
