//
//  MSAlertControllerComponent.swift
//  MSAlertController
//
//  Created by Jacob King on 13/01/2017.
//  Copyright © 2017 Militia Softworks Ltd. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
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
