//
//  SearchEndpoint.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import Foundation

enum SearchEndpoint {
    case search(query: String?)
}

extension SearchEndpoint: EndPointType {
    private static let apiKey = "028bb5d50ceeb79a3053ecfeca662ff9"

    var baseURL: URL {
        let base: String

        switch self {
        case .search:
            base = "https://api.flickr.com"
        }
        guard let url = URL(string: base) else { fatalError("baseURL could not be configured.")}
        return url
    }

    var path: String {
        switch self {
        case .search: return "/services/rest/"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        switch self {
        case let .search(query):
            return .requestParameters(bodyEncoding: .urlEncoding,
                                      urlParameters: ["method": "flickr.photos.search",
                                                      "api_key": SearchEndpoint.apiKey,
                                                      "text": query ?? "flowers",
                                                      "extras": "url_s",
                                                      "format": "json",
                                                      "nojsoncallback": "1"])
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }
}
