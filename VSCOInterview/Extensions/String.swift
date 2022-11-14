//
//  String.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/13/22.
//

import Foundation

extension String {
    func trimmingSpaces(using characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
        components(separatedBy: characterSet).joined()
    }
}
