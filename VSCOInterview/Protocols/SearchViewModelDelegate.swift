//
//  SearchViewModelDelegate.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func postsDidChange()
    func showErrorView(message: String)
}
