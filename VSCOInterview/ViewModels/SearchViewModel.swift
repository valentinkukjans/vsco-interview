//
//  SearchViewModel.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import Foundation

final class SearchViewModel: SearchViewModelProtocol {
    private var repository: SearchRepositoryProtocol
    private var _defaultSearchResult: SearchResult?
    private var state: SearchState = .inactive
    private var currentSearchQuery = SearchQuery.default
    private var isFirstPage: Bool { currentSearchQuery.page == .zero }
    private var prefetchThreshold: Int { posts.count-20 }
    weak var delegate: SearchViewModelDelegate?

    private var searchResult: SearchResult? {
        didSet {
            guard _defaultSearchResult == nil else { return }
            _defaultSearchResult = searchResult
        }
    }
    
    var posts: [Post] = [] {
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
            fetch(with: currentSearchQuery)
            
        case let .canLoadMore(indexPath):
            canLoadMore(for: indexPath)
            
        case let .search(query):
            search(with: query)
        }
    }
    
    // MARK: - Private methods
    
    func search(with query: String?) {
        guard let query, !query.isEmpty else {
            setDefaultSearchResult()
            return
        }
        currentSearchQuery = SearchQuery(text: query, page: .zero)
        fetch(with: currentSearchQuery)
    }
    
    private func fetch(with searchQuery: SearchQuery) {
        guard state == .inactive else { return }
        currentSearchQuery = searchQuery
        state = .active

        Task {
            do {
                let searchResult = try await repository.fetch(with: searchQuery.text, page: searchQuery.page)
                await handleSearchResult(searchResult)
            } catch {
                await handleFailedSearchResult(with: error)
            }
        }
    }
    
    @MainActor
    private func handleSearchResult(_ searchResult: SearchResult) {
        self.searchResult = searchResult

        if isFirstPage {
            posts = []
            posts = searchResult.posts
        } else {
            posts.append(contentsOf: searchResult.posts)
        }
        state = .inactive
    }
    
    @MainActor
    private func handleFailedSearchResult(with error: Error) {
        posts = []
        state = .inactive
        delegate?.showErrorView(message: error.localizedDescription)
    }
    
    private func shouldFetchMore(indexPath: IndexPath) -> Bool {
        indexPath.row >= posts.count
    }
    
    private func canLoadMore(for indexPaths: [IndexPath]) {
        if indexPaths.contains(where: { $0.row >= prefetchThreshold }),
           currentSearchQuery.page < searchResult?.total ?? 0 {
            fetch(with: currentSearchQuery.incrementPage())
        }
    }

    private func setDefaultSearchResult() {
        posts = _defaultSearchResult?.posts ?? []
    }
}

private extension SearchViewModel {
    enum SearchState: Equatable {
        case active
        case inactive
    }
}
