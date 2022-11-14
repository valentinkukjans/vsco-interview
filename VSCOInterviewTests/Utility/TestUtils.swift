//
//  TestUtils.swift
//  VSCOInterviewTests
//
//  Created by Valentins Kukjans on 11/13/22.
//

import Foundation

class TestUtils {
    static func getJsonData(forResource fileName: String, ofType type: String) -> Data {
        guard let path = Bundle(for: TestUtils.self).path(forResource: fileName, ofType: type) else {
            fatalError("Bundle resource '\(fileName) ofType '\(type)' does not exist")
        }
        return try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
}
