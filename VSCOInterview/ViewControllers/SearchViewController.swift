//
//  SearchViewController.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/10/22.
//

import UIKit

final class SearchViewController: UIViewController {

    private var prefetchDataSource: PrefetchingDataSource?
    private(set) var dataSource: UICollectionViewDiffableDataSource<Section, Post>?
    private(set) var viewModel: SearchViewModelProtocol

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        definesPresentationContext = true
        return searchController
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: .createCollectionViewLayout())
        collectionView.delegate = self
        collectionView.prefetchDataSource = prefetchDataSource
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        return collectionView
    }()
    
    // MARK: - Initialization
    
    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSubviews()
        createDataSource()
        fetch()
    }
    
    // MARK: - Private methods
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Post>()
        snapshot.deleteAllItems()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(viewModel.posts, toSection: .main)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func fetch() {
        viewModel.dispatch(action: .fetch)
    }
    
    private func createSubviews() {
        navigationItem.searchController = searchController
        view.backgroundColor = .white
        title = "Flickr Search"
    }
}

private extension SearchViewController {
    func createDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<PostCollectionViewCell, Post> { cell, indexPath, post in
            cell.configure(with: PostCellViewModel(post: post))
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Post>(collectionView: collectionView, cellProvider: cellRegistration.cellProvider)


        prefetchDataSource = PrefetchingDataSource(for: collectionView) { [weak self] indexPaths in
            self?.viewModel.dispatch(action: .canLoadMore(indexPaths))
        }
    }
}

extension SearchViewController {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UICollectionViewDelegate {
    // Need conformance to UICollectionViewDelegate, in order to triggr above ScrollView delegate method
}

extension SearchViewController: SearchViewModelDelegate {
    func postsDidChange() {
        reloadData()
    }

    func showErrorView(message: String) {
        // show error view
    }
}

extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.dispatch(action: .search(searchController.searchBar.text))
    }
}

extension UICollectionViewLayout {
    static func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize)

        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: fullPhotoItem,
            count: 2)

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
