//
//  NetworkManagerProtocol.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/10/22.
//

import Foundation

protocol NetworkManagerProtocol: AnyObject {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint) async throws -> Data
}
