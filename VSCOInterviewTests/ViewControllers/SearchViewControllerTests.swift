//
//  SearchViewControllerTests.swift
//  VSCOInterviewTests
//
//  Created by Valentins Kukjans on 11/14/22.
//

import XCTest
@testable import VSCOInterview

class SearchViewControllerTests: XCTestCase {
    var sut: SearchViewController!
    var viewModelMock: SearchViewModelMock!

    override func setUp() {
        super.setUp()
        viewModelMock = SearchViewModelMock()
        sut = SearchViewController(viewModel: viewModelMock)
    }

    override func tearDown() {
        sut = nil
        viewModelMock = nil
        super.tearDown()
    }

    func testFetchOnViewDidLoadSuccess() {
        // Given
        viewModelMock.posts = PostFixtures.posts

        // When
        _ = sut.view

        // Then
        XCTAssertEqual(viewModelMock.didCallFetch, true)
        XCTAssertTrue(sut.dataSource!.collectionView(sut.collectionView, numberOfItemsInSection: 0) == PostFixtures.posts.count)
        XCTAssertEqual(sut.dataSource!.itemIdentifier(for: IndexPath(row: PostFixtures.posts.count-1, section: 0)), PostFixtures.posts.last!)
        let snapshot = sut.dataSource?.snapshot()
        XCTAssertEqual(snapshot?.sectionIdentifier(containingItem: PostFixtures.posts.first!), .main)
        XCTAssertEqual(snapshot!.numberOfSections, 1)
        XCTAssertEqual(snapshot!.itemIdentifiers(inSection: .main), PostFixtures.posts)
    }

    func testFetchOnViewDidLoadFailure() {
        // Given
        viewModelMock.posts = []

        // When
        _ = sut.view

        // Then
        XCTAssertTrue(sut.collectionView.backgroundView is ErrorView)
    }
}
