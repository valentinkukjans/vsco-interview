//
//  CellRegistration.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import UIKit

extension UICollectionView.CellRegistration {
    var cellProvider: (UICollectionView, IndexPath, Item) -> Cell {
        { collectionView, indexPath, product in
            collectionView.dequeueConfiguredReusableCell(using: self, for: indexPath, item: product)
        }
    }
}
