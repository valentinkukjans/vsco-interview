//
//  SearchServiceProtocol.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import Foundation

protocol SearchServiceProtocol {
    func fetch(with searchQuery: SearchQuery) async throws -> SearchResult}
