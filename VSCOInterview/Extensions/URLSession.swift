//
//  URLSession.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/13/22.
//

import Foundation

extension URLSession {
    static func testConfiguration() -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: config)
    }
}
