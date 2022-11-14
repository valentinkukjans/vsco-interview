//
//  ProcessInfo.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/13/22.
//

import Foundation

extension ProcessInfo {
    var isRunningTests: Bool { environment["XCTestConfigurationFilePath"] != nil }
}
