//
//  UIView+PMGAlertController.swift
//  PMGAlertController
//
//  Created by Jacob King on 13/01/2017.
//  Copyright © 2017 Parkmobile Group. All rights reserved.
//

import UIKit

internal extension NSLayoutConstraint {
    
    static func pinning(attribute: NSLayoutAttribute, ofView firstView: UIView, toView secondView: UIView, multiplier: CGFloat = 1, offset: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: firstView, attribute: attribute, relatedBy: .equal, toItem: secondView, attribute: attribute, multiplier: 1, constant: 0)
    }
    
    static func pinning(attributes: [NSLayoutAttribute], ofView firstView: UIView, toView secondView: UIView, multiplier: CGFloat = 1, offset: CGFloat = 0) -> [NSLayoutConstraint] {
        return attributes.map { return NSLayoutConstraint(item: firstView, attribute: $0, relatedBy: .equal, toItem: secondView, attribute: $0, multiplier: 1, constant: 0) }
    }
}

internal extension UIView {
    
    /// Pins view to superview on all four sides.
    @discardableResult func pinToSuperview() -> (top: NSLayoutConstraint, left: NSLayoutConstraint, bottom: NSLayoutConstraint, right: NSLayoutConstraint)? {
        guard let parent = self.superview else {
            return nil
        }
        let constraints = NSLayoutConstraint.pinning(attributes: [.top, .left, .bottom, .right], ofView: self, toView: parent)
        parent.addConstraints(constraints)
        parent.layoutIfNeeded()
        return (top: constraints[0], left: constraints[1], bottom: constraints[2], right: constraints[3])
    }
}
