//
//  MSAlertTextFieldComponent.swift
//  MSAlertController
//
//  Created by Jacob King on 13/01/2017.
//  Copyright © 2017 Militia Softworks Ltd. All rights reserved.
//

import UIKit

public class MSAlertControllerTextFieldComponent: MSAlertControllerComponent, MSAlertControllerThemableComponent, UITextFieldDelegate {
    
    @IBOutlet private var textField: UITextField!
    
    public var text: String {
        get {
            return textField.text ?? ""
        }
        set {
            textField.text = newValue
        }
    }
    
    public func applyTheme(_ theme: MSAlertControllerTheme) {
        self.textField.font = theme.textfieldFont
        self.textField.attributedPlaceholder = NSAttributedString(string: self.textField.placeholder!, attributes: [NSFontAttributeName: theme.textfieldFont])
        self.textField.borderStyle = .none
        self.textField.layer.borderColor = theme.textfieldBorderColor.cgColor
        self.textField.layer.borderWidth = 1
        self.textField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
    }
    
    internal static func empty() -> MSAlertControllerTextFieldComponent {
        let selfFromNib = UINib(nibName: "MSAlertControllerTextFieldComponent", bundle: Bundle(identifier: "com.pmg.MSAlertController")).instantiate(withOwner: nil, options: nil).first as! MSAlertControllerTextFieldComponent
        return selfFromNib
    }
    
    public static func withPlaceholderText(_ text: String) -> MSAlertControllerTextFieldComponent {
        let base = empty()
        base.textField.placeholder = text
        return base
    }
    
    public static func withPlaceholderText(_ text: String, keyboard: UIKeyboardType, secureEntry: Bool) -> MSAlertControllerTextFieldComponent {
        let base = empty()
        base.textField.placeholder = text
        base.textField.keyboardType = keyboard
        base.textField.isSecureTextEntry = secureEntry
        return base
    }
    
    public static func withCustomConfiguration(_ configHandler: @escaping ((_ textfield: UITextField) -> Void)) -> MSAlertControllerTextFieldComponent {
        let base = empty()
        configHandler(base.textField)
        return base
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(false)
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}
