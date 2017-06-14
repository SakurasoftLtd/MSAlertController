//
//  MSAlertControllerComponent.swift
//  MSAlertController
//
//  Created by Jacob King on 13/01/2017.
//  Copyright © 2017 Militia Softworks Ltd. All rights reserved.
//

import UIKit

// This is the base component, all others will inheirit from this including custom user classes if they so wish.
open class MSAlertControllerComponent: UIView {
    
    @IBOutlet internal var topConstraint: NSLayoutConstraint?
    @IBOutlet internal var bottomConstraint: NSLayoutConstraint?
    @IBOutlet internal var leftConstraint: NSLayoutConstraint?
    @IBOutlet internal var rightConstraint: NSLayoutConstraint?
    @IBOutlet internal var heightConstraint: NSLayoutConstraint?
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    open func applyConstraintMap(_ map: MSAlertControllerConstraintMap) {
        self.leftConstraint?.constant = map.leftInset
        self.rightConstraint?.constant = map.rightInset
        self.topConstraint?.constant = map.topInset
        self.bottomConstraint?.constant = map.bottomInset
        self.heightConstraint?.constant = map.height
    }
}
