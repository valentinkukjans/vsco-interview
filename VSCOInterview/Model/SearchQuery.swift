//
//  SearchQuery.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/13/22.
//

import Foundation

struct SearchQuery {
    let text: String
    let page: Int

    static let `default` = SearchQuery(text: "flowers", page: 1)

    func incrementPage() -> Self {
        Self(text: text, page: page + 1)
    }
}
