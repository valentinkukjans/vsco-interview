//
//  PrefetchingDataSource.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/12/22.
//

import UIKit

final class PrefetchingDataSource: NSObject, UICollectionViewDataSourcePrefetching {

    private let onPrefetch: ([IndexPath]) -> Void

    init(for collectionView: UICollectionView, onPrefetch: @escaping ([IndexPath]) -> Void) {
        self.onPrefetch = onPrefetch
        super.init()
        collectionView.prefetchDataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        onPrefetch(indexPaths)
    }

    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
    }
}
