//
//  ErrorView.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/12/22.
//

import UIKit

final class ErrorView: UIView {
    
    private(set) lazy var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.accessibilityIdentifier = "messageLabel"
        messageLabel.adjustsFontForContentSizeCategory = true
        messageLabel.font = UIFont.preferredFont(forTextStyle: .title1).bold()
        messageLabel.sizeToFit()
        addSubview(messageLabel)
        return messageLabel
    }()
    
    private lazy var errorImageView: UIImageView = {
        let image = UIImage(systemName: "exclamationmark.triangle.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 150)))
        let errorImageView = UIImageView(image: image)
        errorImageView.tintColor = .systemRed
        errorImageView.translatesAutoresizingMaskIntoConstraints = false
        errorImageView.contentMode = .scaleAspectFit
        errorImageView.accessibilityIdentifier = "errorImageView"
        errorImageView.clipsToBounds = true
        errorImageView.layer.masksToBounds = true
        addSubview(errorImageView)
        return errorImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = .white
        messageLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 20).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        errorImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -44).isActive = true
        errorImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        errorImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    required init?(coder: NSCoder) { nil }
}
