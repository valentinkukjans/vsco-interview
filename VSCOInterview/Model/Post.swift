//
//  Post.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import Foundation

struct Post: Decodable, Equatable, Hashable {
    let uuid = UUID()
    let title: String
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case title
        case imageUrl = "url_s"
    }
}
