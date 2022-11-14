//
//  SearchViewModelObserver.swift
//  VSCOInterviewTests
//
//  Created by Valentins Kukjans on 11/14/22.
//

import Foundation
@testable import VSCOInterview

final class SearchViewModelObserver: SearchViewModelDelegate {
    var didCallPostsDidChange = false
    var didCallShowErrorView = false
    var message: String?

    func postsDidChange() {
        didCallPostsDidChange.toggle()
    }

    func showErrorView(message: String) {
        self.message = message
        didCallShowErrorView.toggle()
    }
}

