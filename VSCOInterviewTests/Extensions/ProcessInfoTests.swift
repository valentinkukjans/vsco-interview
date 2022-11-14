//
//  ProcessInfoTests.swift
//  VSCOInterviewTests
//
//  Created by Valentins Kukjans on 11/13/22.
//

import XCTest
@testable import VSCOInterview

class ProcessInfoTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testShouldReturnTrueWhenTesting() {
        XCTAssertTrue(ProcessInfo.processInfo.isRunningTests)
    }
}
