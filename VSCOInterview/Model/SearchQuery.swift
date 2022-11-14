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

    init(text: String, page: Int) {
        self.text = text
        self.page = page
    }

    init(text: String) {
        self.init(text: text, page: .zero)
    }

    static let `default` = SearchQuery(text: "flowers", page: 1)

    func incrementPage() -> Self {
        Self(text: text, page: page + 1)
    }
}
