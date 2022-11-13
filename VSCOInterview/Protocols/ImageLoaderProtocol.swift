//
//  ImageLoaderProtocol.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import UIKit

protocol ImageLoaderProtocol {
    func fetch(from urlString: String?) async throws -> UIImage
    func fetch(_ urlRequest: URLRequest) async throws -> UIImage
}
