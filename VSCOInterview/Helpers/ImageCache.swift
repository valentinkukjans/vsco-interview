//
//  ImageCache.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import UIKit

final class ImageCache: NSCache<NSString, UIImage> {
    static let shared = ImageCache()

    func setImage(_ image: UIImage?, for url: URL) {
        setImage(image, for: url.absoluteString)
    }

    func setImage(_ image: UIImage?, for urlString: String) {
        guard let image = image else {
            removeObject(forKey: urlString as NSString)
            return
        }

        setObject(image, forKey: urlString as NSString)
    }

    func getImage(for url: URL) -> UIImage? {
        getImage(for: url.absoluteString)
    }

    func getImage(for urlString: String) -> UIImage? {
        object(forKey: urlString as NSString)
    }
    
    func removeImage(for url: URL) {
        removeImage(for: url.absoluteString)
    }

    func removeImage(for urlString: String) {
        removeObject(forKey: urlString as NSString)
    }
}
