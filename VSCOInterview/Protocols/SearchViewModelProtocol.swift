//
//  SearchViewModelProtocol.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import Foundation

protocol SearchViewModelProtocol {
    func dispatch(action: SearchViewModel.Action)
    var delegate: SearchViewModelDelegate? { get set }
    var posts: [Post]? { get set }
}
