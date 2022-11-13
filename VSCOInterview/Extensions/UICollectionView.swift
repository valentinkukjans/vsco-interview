//
//  UICollectionView.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/12/22.
//

import UIKit

extension UICollectionView {
    func showErrorView(with message: String) {
        let errorView = ErrorView(frame: bounds)
        errorView.messageLabel.text = message
        backgroundView = errorView
    }

    func restore() {
        backgroundView = nil
    }
}
