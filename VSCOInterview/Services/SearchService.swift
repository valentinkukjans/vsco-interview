//
//  SearchService.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import Foundation

struct SearchService: SearchServiceProtocol {
    func fetch(with query: String) async throws -> PageResponse {
        let data = try await NetworkManager<SearchEndpoint>().request(.search(query: query))
        return try JSONDecoder().decode(Wrapper<PageResponse>.self, from: data).photos
    }
}
