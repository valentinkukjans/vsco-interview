//
//  SearchViewModelMock.swift
//  VSCOInterviewTests
//
//  Created by Valentins Kukjans on 11/14/22.
//

import Foundation
@testable import VSCOInterview

final class SearchViewModelMock: SearchViewModelProtocol {
    var delegate: SearchViewModelDelegate?
    var posts: [Post] = []
    var didCallFetch = false

    func dispatch(action: SearchViewModel.Action) {
        switch action {
        case .fetch:
            didCallFetch = true
            posts.isEmpty ? delegate?.showErrorView(message: "error ") : delegate?.postsDidChange()
        default: break
        }
    }
}
