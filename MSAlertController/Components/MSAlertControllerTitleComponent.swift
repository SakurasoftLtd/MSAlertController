//
//  MSAlertControllerTitleComponent.swift
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

open class MSAlertControllerTitleComponent: MSAlertControllerComponent, MSAlertControllerThemableComponent {
    
    @IBOutlet private var label: UILabel!
    
    open func applyTheme(_ theme: MSAlertControllerTheme) {
        self.label.textColor = theme.titleTextColor
        self.label.textAlignment = theme.titleTextAlignment
        self.label.font = theme.titleFont
    }
    
    internal static func empty() -> MSAlertControllerTitleComponent {
        let selfFromNib = UINib(nibName: "MSAlertControllerTitleComponent", bundle: Bundle(identifier: "uk.co.militiasoftworks.msalertcontroller")).instantiate(withOwner: nil, options: nil).first as! MSAlertControllerTitleComponent
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
