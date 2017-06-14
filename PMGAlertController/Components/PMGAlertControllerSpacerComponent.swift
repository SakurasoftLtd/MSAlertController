//
//  PMGAlertControllerSpacerComponent.swift
//  PMGAlertController
//
//  Created by Jacob King on 13/01/2017.
//  Copyright © 2017 Parkmobile Group. All rights reserved.
//

import UIKit

open class PMGAlertControllerSpacerComponent: PMGAlertControllerComponent {
    
    @IBOutlet private var spacerView: UIView!
    
    open static func withSpacing(_ spacing: CGFloat) -> PMGAlertControllerSpacerComponent {
        let selfFromNib = UINib(nibName: "PMGAlertControllerSpacerComponent", bundle: Bundle(identifier: "com.pmg.PMGAlertController")).instantiate(withOwner: nil, options: nil).first as! PMGAlertControllerSpacerComponent
        selfFromNib.heightConstraint?.constant = spacing
        selfFromNib.spacerView.translatesAutoresizingMaskIntoConstraints = false
        return selfFromNib
    }
}
