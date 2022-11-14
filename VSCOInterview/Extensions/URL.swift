//
//  URL.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/14/22.
//

import Foundation

extension URL {
    func queryItemValue(for name: String) -> String? {
        URLComponents(string: absoluteString)?.queryItems?.first { $0.name == name }?.value
    }
}
