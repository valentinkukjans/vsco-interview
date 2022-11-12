//
//  SearchViewModel.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import Foundation

@MainActor
class SearchViewModel: SearchViewModelProtocol {
    private var repository: SearchRepositoryProtocol
    weak var delegate: SearchViewModelDelegate?
    private var pageResponse: PageResponse?

    private(set) var posts: [Post]? {
        didSet {
            delegate?.postsDidChange()
        }
    }
    
    // MARK: - Initialization
    
    init(repository: SearchRepositoryProtocol = SearchRepository()) {
        self.repository = repository
    }
    
    // MARK: - Public methods
    
    func fetch() async {
        Task {
            let searchResult = try await repository.fetch(with: "flowers")
            posts = searchResult.posts
        }
    }
}
