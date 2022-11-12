//
//  Wrapper.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import Foundation

struct Wrapper<T: Decodable>: Decodable {
    let photos: T
}
