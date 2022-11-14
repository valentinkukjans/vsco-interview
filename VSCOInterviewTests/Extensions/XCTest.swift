//
//  XCTest.swift
//  VSCOInterviewTests
//
//  Created by Valentins Kukjans on 11/14/22.
//

import XCTest

extension XCTest {
    func expectToEventually(_ test: @autoclosure () -> Bool, timeout: TimeInterval = 1.0, message: String = "") {
        repeat {
            if test() {
                return
            }
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
        } while Date().compare(Date(timeIntervalSinceNow: timeout)) == .orderedAscending
        XCTFail(message)
    }
}
