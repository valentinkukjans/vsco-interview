//
//  SearchViewModel.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import Foundation

class SearchViewModel: SearchViewModelProtocol {
    private var repository: SearchRepositoryProtocol
    weak var delegate: SearchViewModelDelegate?
    private var pageResponse: PageResponse?
    private var currentPage = 1
    
    private var isFirstPage: Bool { currentPage == 1 }
    
    var posts: [Post]? {
        didSet {
            delegate?.postsDidChange()
        }
    }
    
    enum Action: Equatable {
        case fetch
        case canLoadMore([IndexPath])
        case search(String?)
    }
    
    // MARK: - Initialization
    
    init(repository: SearchRepositoryProtocol = SearchRepository()) {
        self.repository = repository
    }
    
    // MARK: - Public methods
    
    func dispatch(action: Action) {
        switch action {
            
        case .fetch:
            fetch()
            
        case let .canLoadMore(indexPath):
            canLoadMore(for: indexPath)
            
        case let .search(query):
            search(with: query)
        }
    }
    
    // MARK: - Private methods
    
    func search(with query: String?) {

    }
    
    private func fetch(with query: String = "flowers", page: Int = 1) {
        Task {
            do {
                let searchResult = try await repository.fetch(with: query, page: page)
                await handleSearchResult(searchResult)
            } catch {
                await handleFailedSearchResult(with: error)
            }
        }
    }
    
    @MainActor
    private func handleSearchResult(_ searchResult: PageResponse) {
        if isFirstPage {
            posts = []
            posts = searchResult.posts
        } else {
            posts?.append(contentsOf: searchResult.posts)
        }
    }
    
    @MainActor
    private func handleFailedSearchResult(with error: Error) {
        delegate?.showErrorView(message: error.localizedDescription)
    }
    
    private func shouldFetchMore(indexPath: IndexPath) -> Bool {
        indexPath.row >= posts?.count ?? 0
    }
    
    private func canLoadMore(for indexPaths: [IndexPath]) {
    }
}
