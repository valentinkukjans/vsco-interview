//
//  CustomImageView.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import UIKit

final class CustomImageView: UIImageView {
    private var imageUrlString: String?
    private(set) var imageLoader: ImageLoaderProtocol

    init(imageLoader: ImageLoaderProtocol = ImageLoader.shared) {
        self.imageLoader = imageLoader
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) { nil }

    func loadImageFrom(urlString: String) async {
        imageUrlString = urlString
        image = nil

        let image = try? await imageLoader.fetch(from: urlString)
        image?.preparingThumbnail(of: size)
        let decodedImage = await image?.byPreparingForDisplay()

        Task.onMainActor { [weak self] in
            if self?.imageUrlString == urlString {
                self?.image = decodedImage
            }
        }
    }
}

