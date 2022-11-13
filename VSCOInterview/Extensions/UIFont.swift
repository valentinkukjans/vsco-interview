//
//  UIFont.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/12/22.
//

import UIKit

extension UIFont {
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        UIFont(descriptor: fontDescriptor.withSymbolicTraits(traits) ?? .init(), size: 0)
    }

    func bold() -> UIFont { withTraits(traits: .traitBold) }
}
