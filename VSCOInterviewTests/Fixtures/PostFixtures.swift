//
//  PostFixtures.swift
//  VSCOInterviewTests
//
//  Created by Valentins Kukjans on 11/14/22.
//

import Foundation
@testable import VSCOInterview

struct PostFixtures {
    static let posts = (1...10).map { Post(title: "\($0)", imageUrl: "some/path/?page=\($0)")  }
}
