//
//  JSONParameterEncoder.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/10/22.
//

import Foundation

struct JSONParameterEncoder: ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
       do {
           let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
           urlRequest.httpBody = jsonAsData
           if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
               urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
           }
       } catch {
           throw ParameterEncodingError.encodingFailed
       }
   }
}
