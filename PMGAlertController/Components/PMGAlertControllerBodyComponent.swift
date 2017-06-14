//
//  PMGAlertControllerBodyComponent.swift
//  PMGAlertController
//
//  Created by Jacob King on 17/01/2017.
//  Copyright © 2017 Parkmobile Group. All rights reserved.
//

import UIKit

open class PMGAlertControllerBodyComponent: PMGAlertControllerComponent, PMGAlertControllerThemableComponent {
    
    @IBOutlet private var label: UILabel!
    
    open func applyTheme(_ theme: PMGAlertControllerTheme) {
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
    
    internal static func empty() -> PMGAlertControllerBodyComponent {
        let selfFromNib = UINib(nibName: "PMGAlertControllerBodyComponent", bundle: Bundle(identifier: "com.pmg.PMGAlertController")).instantiate(withOwner: nil, options: nil).first as! PMGAlertControllerBodyComponent
        return selfFromNib
    }
    
    open static func withBodyText(_ text: String) -> PMGAlertControllerBodyComponent {
        let base = empty()
        base.label.text = text
        return base
    }
    
    open static func withAttributedBodyText(_ attributedText: NSAttributedString) -> PMGAlertControllerBodyComponent {
        let base = empty()
        base.label.attributedText = attributedText
        return base
    }
    
    open static func withCustomConfiguration(_ configHandler: @escaping ((_ label: UILabel) -> Void)) -> PMGAlertControllerBodyComponent {
        let base = empty()
        configHandler(base.label)
        return base
    }
}
