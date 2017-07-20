//
//  MSAlertControllerButtonComponent.swift
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

open class MSAlertControllerButtonComponent: MSAlertControllerComponent, MSAlertControllerThemableComponent {
    
    @IBOutlet private var button: UIButton!
    @IBOutlet private var separatorView: UIView!
    
    private var buttonAction: ((_ sender: Any) -> Void)!
    
    @IBAction private func buttonPressed(_ sender: Any) {
        self.buttonAction(sender)
    }
    
    open func applyTheme(_ theme: MSAlertControllerTheme) {
        switch self.tag {
        case 2: self.button.setTitleColor(theme.destructiveButtonTextColor, for: .normal)
        case 3: self.button.setTitleColor(theme.submissiveButtonTextColor, for: .normal)
        default: self.button.setTitleColor(theme.standardButtonTextColor, for: .normal)
        }
        self.heightConstraint?.constant = theme.defaultButtonHeight
        self.button.titleLabel?.font = theme.buttonFont
        self.separatorView.backgroundColor = theme.separatorColor
    }
    
    internal static func empty() -> MSAlertControllerButtonComponent {
        let selfFromNib = UINib(nibName: "MSAlertControllerButtonComponent", bundle: Bundle(identifier: "uk.co.militiasoftworks.msalertcontroller")).instantiate(withOwner: nil, options: nil).first as! MSAlertControllerButtonComponent
        selfFromNib.button.translatesAutoresizingMaskIntoConstraints = false
        selfFromNib.separatorView.translatesAutoresizingMaskIntoConstraints = false
        // TODO: Resize buttons according to theme.
        return selfFromNib
    }
    
    open static func withCustomConfiguration(_ configHandler: @escaping ((_ button: UIButton) -> Void), andButtonAction action: @escaping ((_ sender: Any) -> Void)) -> MSAlertControllerButtonComponent {
        let base = empty()
        base.buttonAction = action
        configHandler(base.button)
        return base
    }
    
    open static func standardButtonWithText(_ text: String, andAction action: @escaping ((_ sender: Any) -> Void)) -> MSAlertControllerButtonComponent {
        let base = empty()
        base.buttonAction = action
        UIView.performWithoutAnimation {
            base.button.setTitle(text, for: .normal)
            base.button.layoutIfNeeded()
        }
        base.tag = 1
        return base
    }
    
    open static func destructiveButtonWithText(_ text: String, andAction action: @escaping ((_ sender: Any) -> Void)) -> MSAlertControllerButtonComponent {
        let base = empty()
        base.buttonAction = action
        UIView.performWithoutAnimation {
            base.button.setTitle(text, for: .normal)
            base.button.layoutIfNeeded()
        }
        base.tag = 2
        return base
    }
    
    open static func submissiveButtonWithText(_ text: String, andAction action: @escaping ((_ sender: Any) -> Void)) -> MSAlertControllerButtonComponent {
        let base = empty()
        base.buttonAction = action
        UIView.performWithoutAnimation {
            base.button.setTitle(text, for: .normal)
            base.button.layoutIfNeeded()
        }
        base.tag = 3
        return base
    }
}
