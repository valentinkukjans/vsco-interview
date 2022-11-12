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

    func fetch(with query: String) async throws -> PageResponse {
        try await service.fetch(with: query)
    }
}
