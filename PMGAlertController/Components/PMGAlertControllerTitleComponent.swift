//
//  PMGAlertControllerTitleComponent.swift
//  PMGAlertController
//
//  Created by Jacob King on 13/01/2017.
//  Copyright © 2017 Parkmobile Group. All rights reserved.
//

import UIKit

open class PMGAlertControllerTitleComponent: PMGAlertControllerComponent, PMGAlertControllerThemableComponent {
    
    @IBOutlet private var label: UILabel!
    
    open func applyTheme(_ theme: PMGAlertControllerTheme) {
        self.label.textColor = theme.titleTextColor
        self.label.textAlignment = theme.titleTextAlignment
        self.label.font = theme.titleFont
    }
    
    internal static func empty() -> PMGAlertControllerTitleComponent {
        let selfFromNib = UINib(nibName: "PMGAlertControllerTitleComponent", bundle: Bundle(identifier: "com.pmg.PMGAlertController")).instantiate(withOwner: nil, options: nil).first as! PMGAlertControllerTitleComponent
        return selfFromNib
    }
    
    open static func withTitleText(_ text: String) -> PMGAlertControllerTitleComponent {
        let base = empty()
        base.label.text = text
        return base
    }
    
    open static func withAttributedTitleText(_ attributedText: NSAttributedString) -> PMGAlertControllerTitleComponent {
        let base = empty()
        base.label.attributedText = attributedText
        return base
    }
    
    open static func withCustomConfiguration(_ configHandler: @escaping ((_ label: UILabel) -> Void)) -> PMGAlertControllerTitleComponent {
        let base = empty()
        configHandler(base.label)
        return base
    }
}
