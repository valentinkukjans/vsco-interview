//
//  UIView.swift
//  VSCOInterview
//
//  Created by Valentins Kukjans on 11/11/22.
//

import UIKit

extension UIView {
    var size: CGSize {
        get {
            CGSize(width: width, height: height)
        }

        set {
            width = newValue.width
            height = newValue.height
        }
    }

    var width: CGFloat {
        get {
            frame.size.width
        }

        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }

    var height: CGFloat {
        get {
            frame.size.height
        }

        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
}
