//
//  SearchViewModelTests.swift
//  VSCOInterviewTests
//
//  Created by Valentins Kukjans on 11/14/22.
//

import XCTest
@testable import VSCOInterview

class SearchViewModelTests: XCTestCase {
    var sut: SearchViewModel!
    var repositoryMock: SearchRepositoryProtocol!
    var observer: SearchViewModelObserver!

    override func setUp() {
        super.setUp()
        observer = SearchViewModelObserver()
    }

    override func tearDown() {
        sut = nil
        repositoryMock = nil
        observer = nil
        super.tearDown()
    }

    func testFetchFailure() {
        // Given
        repositoryMock = SearchRepositoryMock(searchResult: nil)
        sut = SearchViewModel(repository: repositoryMock)
        sut.delegate = observer

        // When
        sut.dispatch(action: .fetch)

        // Then
        expectToEventually(observer.didCallShowErrorView, timeout: 3)
        XCTAssertTrue(observer.didCallShowErrorView)
        XCTAssertEqual(observer.message, "Something went wrong. Please try again later.")
        XCTAssert(sut.posts.isEmpty)
    }

    func testFetchSuccess() {
        // Given
        let searchResult = SearchResult(page: 2, pages: 777, total: 345, posts: [Post(title: "bar", imageUrl: "some/path/somewhere"), Post(title: "foo", imageUrl: "some/path/somewhere/cool")])

        repositoryMock = SearchRepositoryMock(searchResult: searchResult)
        sut = SearchViewModel(repository: repositoryMock)
        sut.delegate = observer

        // When
        sut.dispatch(action: .fetch)

        // Then
        expectToEventually(observer.didCallPostsDidChange, timeout: 3)
        XCTAssertTrue(observer.didCallPostsDidChange)
        XCTAssertFalse(observer.didCallShowErrorView)
        XCTAssertFalse(sut.posts.isEmpty)
        XCTAssertEqual(sut.posts.count, 2)
        XCTAssertEqual(sut.posts.first?.title, "bar")
        XCTAssertEqual(sut.posts.last?.title, "foo")
        XCTAssertEqual(sut.posts.first?.imageUrl, "some/path/somewhere")
        XCTAssertEqual(sut.posts.last?.imageUrl, "some/path/somewhere/cool")
    }

    func testSearchShouldCallFetch() {
        // Given
        let searchResult = SearchResult(page: 2, pages: 777, total: 345, posts: [Post(title: "bar", imageUrl: "some/path/somewhere"), Post(title: "foo", imageUrl: "some/path/somewhere/cool")])
        let searchQuery = "foo"
        repositoryMock = SearchRepositoryMock(searchResult: searchResult)
        sut = SearchViewModel(repository: repositoryMock)

        // sanity check
        XCTAssertEqual(sut.currentSearchQuery.text,  SearchQuery.default.text)
        XCTAssertEqual(sut.state, .inactive)

        // When
        sut.dispatch(action: .search(searchQuery))

        // Then
        XCTAssertEqual(sut.currentSearchQuery.text, searchQuery)
        XCTAssertEqual(sut.state, .active)
    }

    func testSearchShouldNotCallFetch() {
        // Given
        let searchResult = SearchResult(page: 2, pages: 777, total: 345, posts: [Post(title: "bar", imageUrl: "some/path/somewhere"), Post(title: "foo", imageUrl: "some/path/somewhere/cool")])
        let searchQuery = ""
        repositoryMock = SearchRepositoryMock(searchResult: searchResult)
        sut = SearchViewModel(repository: repositoryMock)

        // sanity check
        XCTAssertEqual(sut.currentSearchQuery.text, SearchQuery.default.text)
        XCTAssertEqual(sut.state, .inactive)

        // When
        sut.dispatch(action: .search(searchQuery))

        // Then
        XCTAssertEqual(sut.currentSearchQuery.text,  SearchQuery.default.text)
        XCTAssertEqual(sut.state, .inactive)
    }

    func testCanLoadMoreShouldCallFetch() {
        // Given
        let expectedSearchResult = SearchResult(page: 2, pages: 777, total: 345, posts: [Post(title: "foo", imageUrl: "some/path/somewhere/cool")])
        let indexPaths = (0...100).map { IndexPath(row: $0, section: 0) }
        repositoryMock = SearchRepositoryMock(searchResult: expectedSearchResult)
        sut = SearchViewModel(repository: repositoryMock)
        sut.delegate = observer
        sut.searchResult = SearchResult(page: 1, pages: 777, total: 345, posts: [Post(title: "bar", imageUrl: "some/path/somewhere")])

        // sanity check
        XCTAssertEqual(sut.currentSearchQuery.page, 1)

        // When
        sut.dispatch(action: .canLoadMore(indexPaths))

        // Then
        expectToEventually(observer.didCallPostsDidChange, timeout: 3)
        XCTAssertTrue(observer.didCallPostsDidChange)
        XCTAssertFalse(observer.didCallShowErrorView)
        XCTAssertEqual(sut.currentSearchQuery.page, expectedSearchResult.page)
        XCTAssertFalse(sut.posts.isEmpty)
        XCTAssertEqual(sut.posts.count, 1)
        XCTAssertEqual(sut.posts.first?.title, "foo")
        XCTAssertEqual(sut.posts.first?.imageUrl, "some/path/somewhere/cool")
    }

    func testCanLoadMoreShouldNotCallFetch() {
        // Given
        let indexPaths = { [IndexPath(row: 0, section: 0)] }
        repositoryMock = SearchRepositoryMock(searchResult: nil)
        sut = SearchViewModel(repository: repositoryMock)
        sut.delegate = observer
        sut.posts = (1...50).map { Post(title: "\($0)", imageUrl: "\($0)") }

        // sanity check
        XCTAssertEqual(sut.currentSearchQuery.page, 1)

        // When
        sut.dispatch(action: .canLoadMore(indexPaths()))

        // Then
        expectToEventually(observer.didCallPostsDidChange, timeout: 3)
        XCTAssertEqual(sut.currentSearchQuery.page, 1)
        XCTAssertFalse(sut.posts.isEmpty)
        XCTAssertEqual(sut.posts.count, 50)
    }
}
