//
//  Task.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import Foundation

extension Task where Success == Void, Failure == Never {

    static func onMainActor(body: @escaping @MainActor @Sendable () async -> Success) {
        Task { await body() }
    }
}
