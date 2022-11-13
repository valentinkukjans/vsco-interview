//
//  SearchService.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import Foundation

struct SearchService: SearchServiceProtocol {
    func fetch(with query: String, page: Int) async throws -> SearchResult {
        let data = try await NetworkManager<SearchEndpoint>().request(.search(query: query, page: page))
        return try JSONDecoder().decode(Wrapper<SearchResult>.self, from: data).photos
    }
}
