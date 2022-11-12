//
//  SearchViewController.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/10/22.
//

import UIKit

final class SearchViewController: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<Section, Post>?
    private(set) var viewModel: SearchViewModel
    
    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: .createCollectionViewLayout())
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        return collectionView
    }()
    
    // MARK: - Initialization
    
    init(viewModel: SearchViewModel) {
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
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(viewModel.posts ?? [], toSection: .main)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    private func fetch() {
        Task {
            await viewModel.fetch()
        }
    }
    
    private func createSubviews() {
        view.backgroundColor = .white
        title = "Photos"
    }
}

private extension SearchViewController {
    func createDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<PostCollectionViewCell, Post> { cell, indexPath, post in
            cell.configure(with: PostCellViewModel(post: post))
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Post>(collectionView: collectionView, cellProvider: cellRegistration.cellProvider)
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
}

extension SearchViewController: SearchViewModelDelegate {
    func postsDidChange() {
        reloadData()
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
            count: 2
        )

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
