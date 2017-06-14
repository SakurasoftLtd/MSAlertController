//
//  MSAlertControllerBodyComponent.swift
//  MSAlertController
//
//  Created by Jacob King on 17/01/2017.
//  Copyright © 2017 Militia Softworks Ltd. All rights reserved.
//

import UIKit

open class MSAlertControllerBodyComponent: MSAlertControllerComponent, MSAlertControllerThemableComponent {
    
    @IBOutlet private var label: UILabel!
    
    open func applyTheme(_ theme: MSAlertControllerTheme) {
        self.label.textColor = theme.bodyTextColor
        self.label.font = theme.bodyFont
        self.label.textAlignment = theme.bodyTextAlignment
        
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.alignment = theme.bodyTextAlignment
        paraStyle.lineSpacing = theme.bodyLineSpacing
        if self.label.attributedText != nil {
            let mutable = NSMutableAttributedString(attributedString: self.label.attributedText!)
            mutable.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: NSMakeRange(0, self.label.attributedText!.length))
            self.label.attributedText = mutable
        } else {
            self.label.attributedText = NSAttributedString(string: self.label.text!, attributes: [NSParagraphStyleAttributeName:paraStyle])
        }
    }
    
    internal static func empty() -> MSAlertControllerBodyComponent {
        let selfFromNib = UINib(nibName: "MSAlertControllerBodyComponent", bundle: Bundle(identifier: "com.pmg.MSAlertController")).instantiate(withOwner: nil, options: nil).first as! MSAlertControllerBodyComponent
        return selfFromNib
    }
    
    open static func withBodyText(_ text: String) -> MSAlertControllerBodyComponent {
        let base = empty()
        base.label.text = text
        return base
    }
    
    open static func withAttributedBodyText(_ attributedText: NSAttributedString) -> MSAlertControllerBodyComponent {
        let base = empty()
        base.label.attributedText = attributedText
        return base
    }
    
    open static func withCustomConfiguration(_ configHandler: @escaping ((_ label: UILabel) -> Void)) -> MSAlertControllerBodyComponent {
        let base = empty()
        configHandler(base.label)
        return base
    }
}
