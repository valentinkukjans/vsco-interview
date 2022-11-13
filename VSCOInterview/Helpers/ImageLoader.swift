//
//  ImageLoader.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import UIKit

actor ImageLoader: ImageLoaderProtocol {
    static let shared: ImageLoader = ImageLoader()
    private let cache = ImageCache.shared

    private init() {}
    
    func fetch(from urlString: String?) async throws -> UIImage {
        guard let urlString, let url = URL(string: urlString) else { throw ServiceError.invalidUrl }
        return try await fetch(URLRequest(url: url))
    }

    func fetch(_ urlRequest: URLRequest) async throws -> UIImage {
        if let image = imageFromCache(for: urlRequest) {
            return image
        }

        let task: Task<UIImage, Error> = Task {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            guard let image = UIImage(data: data) else { throw ServiceError.invalidData }
            setImage(image, for: urlRequest)
            return image
        }

        return try await task.value
    }

    private func setImage(_ image: UIImage?, for urlRequest: URLRequest) {
        guard let url = urlRequest.url else { return }
        cache.setImage(image, for: url)
    }

    private func imageFromCache(for urlRequest: URLRequest) -> UIImage? {
        guard let url = urlRequest.url else { return nil }
        return cache.getImage(for: url)
    }
}
