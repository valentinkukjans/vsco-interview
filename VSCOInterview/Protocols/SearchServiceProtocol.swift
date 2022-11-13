//
//  SearchServiceProtocol.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import Foundation

protocol SearchServiceProtocol {
    func fetch(with query: String, page: Int) async throws -> SearchResult}
