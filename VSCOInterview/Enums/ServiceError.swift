//
//  ServiceError.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/10/22.
//

import Foundation

enum ServiceError: Error {
    case invalidResponse(String)
    case errorResponse(statusCode: Int)
    case invalidRequest
    case invalidUrl
    case invalidData
}

extension ServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .invalidResponse(message):
            return "Bad response: \(message)"
        case .invalidRequest, .errorResponse, .invalidUrl, .invalidData:
            return "Something went wrong. Please try again later."
        }
    }
}
