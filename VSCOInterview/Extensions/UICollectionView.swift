//
//  UICollectionView.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/12/22.
//

import UIKit

extension UICollectionView {
    func showErrorView(with message: String) {
        let errorView = ErrorView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        errorView.messageLabel.text = message
        backgroundView = errorView
    }

    func restore() {
        backgroundView = nil
    }
}
