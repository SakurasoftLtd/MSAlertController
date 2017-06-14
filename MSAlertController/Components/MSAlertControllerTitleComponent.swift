//
//  MSAlertControllerTitleComponent.swift
//  MSAlertController
//
//  Created by Jacob King on 13/01/2017.
//  Copyright © 2017 Militia Softworks Ltd. All rights reserved.
//

import UIKit

open class MSAlertControllerTitleComponent: MSAlertControllerComponent, MSAlertControllerThemableComponent {
    
    @IBOutlet private var label: UILabel!
    
    open func applyTheme(_ theme: MSAlertControllerTheme) {
        self.label.textColor = theme.titleTextColor
        self.label.textAlignment = theme.titleTextAlignment
        self.label.font = theme.titleFont
    }
    
    internal static func empty() -> MSAlertControllerTitleComponent {
        let selfFromNib = UINib(nibName: "MSAlertControllerTitleComponent", bundle: Bundle(identifier: "com.pmg.MSAlertController")).instantiate(withOwner: nil, options: nil).first as! MSAlertControllerTitleComponent
        return selfFromNib
    }
    
    open static func withTitleText(_ text: String) -> MSAlertControllerTitleComponent {
        let base = empty()
        base.label.text = text
        return base
    }
    
    open static func withAttributedTitleText(_ attributedText: NSAttributedString) -> MSAlertControllerTitleComponent {
        let base = empty()
        base.label.attributedText = attributedText
        return base
    }
    
    open static func withCustomConfiguration(_ configHandler: @escaping ((_ label: UILabel) -> Void)) -> MSAlertControllerTitleComponent {
        let base = empty()
        configHandler(base.label)
        return base
    }
}
