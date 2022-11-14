//
//  URLProtocolMock.swift
//  VSCOInterviewTests
//
//  Created by Valentins Kukjans on 11/13/22.
//

import Foundation

final class URLProtocolMock: URLProtocol {

    static var testURLs = [String?: Data]()

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let url = request.url {
            if let data = URLProtocolMock.testURLs[url.queryItemValue(for: "text")] {
                client?.urlProtocol(self, didLoad: data)
            } else {
                client?.urlProtocol(self, didFailWithError: ServiceError.invalidRequest);
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() { }
}
