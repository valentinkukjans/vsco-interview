//
//  PageResponse.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import Foundation

struct PageResponse: Decodable {
    let page: Int
    let pages: Int
    let total: Int
    let posts: [Post]

    enum CodingKeys: String, CodingKey {
        case page
        case pages
        case total
        case posts = "photo"
    }
}
