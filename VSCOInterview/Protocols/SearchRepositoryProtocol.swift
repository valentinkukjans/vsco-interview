//
//  SearchRepositoryProtocol.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import Foundation

protocol SearchRepositoryProtocol {
    func fetch(with query: String, page: Int) async throws -> PageResponse
}
