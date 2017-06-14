//
//  MSAlertControllerSpacerComponent.swift
//  MSAlertController
//
//  Created by Jacob King on 13/01/2017.
//  Copyright © 2017 Militia Softworks Ltd. All rights reserved.
//

import UIKit

open class MSAlertControllerSpacerComponent: MSAlertControllerComponent {
    
    @IBOutlet private var spacerView: UIView!
    
    open static func withSpacing(_ spacing: CGFloat) -> MSAlertControllerSpacerComponent {
        let selfFromNib = UINib(nibName: "MSAlertControllerSpacerComponent", bundle: Bundle(identifier: "com.pmg.MSAlertController")).instantiate(withOwner: nil, options: nil).first as! MSAlertControllerSpacerComponent
        selfFromNib.heightConstraint?.constant = spacing
        selfFromNib.spacerView.translatesAutoresizingMaskIntoConstraints = false
        return selfFromNib
    }
}
