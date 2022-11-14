//
//  PostCollectionViewCell.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import UIKit

final class PostCollectionViewCell: UICollectionViewCell {

    private(set) lazy var thumbnailImageView: CustomImageView = {
        let thumbnailImageView = CustomImageView()
        thumbnailImageView.accessibilityIdentifier = "thumbnailImageView"
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.layer.masksToBounds = true
        thumbnailImageView.backgroundColor = .lightGray.withAlphaComponent(0.1)
        contentView.addSubview(thumbnailImageView)
        return thumbnailImageView
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) { nil }

    private func setupView() {
        backgroundColor = .white
        thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private(set) var viewModel: PostCellViewModel? {
        didSet {
            guard let post = viewModel?.post else { return }
            update(with: post)
        }
    }

    // MARK: - Public methods

    func configure(with viewModel: PostCellViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Private methods

    private func update(with post: Post) {
        Task {
            await thumbnailImageView.loadImageFrom(urlString: post.imageUrl)
        }
    }
}
