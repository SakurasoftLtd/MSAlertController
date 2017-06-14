//
//  MSAlertControllerTheme.swift
//  MSAlertController
//
//  Created by Jacob King on 16/01/2017.
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

open class MSAlertControllerTheme: NSObject {
    
    open var alertCornerRadius: CGFloat = 0
    
    open var titleFont: UIFont = UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
    open var bodyFont: UIFont = UIFont.systemFont(ofSize: 13, weight: UIFontWeightRegular)
    open var buttonFont: UIFont = UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
    open var textfieldFont: UIFont = UIFont.systemFont(ofSize: 17, weight: UIFontWeightRegular)
    
    open var titleTextColor: UIColor = UIColor(red: 0/255, green: 127/255, blue: 163/255, alpha: 1)
    open var bodyTextColor: UIColor = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1)
    open var standardButtonTextColor: UIColor = UIColor(red: 0/255, green: 127/255, blue: 163/255, alpha: 1)
    open var destructiveButtonTextColor: UIColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
    open var submissiveButtonTextColor: UIColor = UIColor(red: 156/255, green: 189/255, blue: 35/255, alpha: 1)
    open var alertWindowBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.4)
    
    open var separatorColor: UIColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
    open var textfieldBorderColor: UIColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    open var checkboxBackgroundColor: UIColor = UIColor.white
    
    open var titleTextAlignment: NSTextAlignment = .left
    open var bodyTextAlignment: NSTextAlignment = .left
    
    open var defaultButtonHeight: CGFloat = 44
    open var defaultTextFieldHeight: CGFloat = 48
    open var defaultCheckboxHeight: CGFloat = 20
    
    open var bodyLineSpacing: CGFloat = 4
    
    open var toastFont: UIFont = UIFont.systemFont(ofSize: 16)
    open var toastTextColor: UIColor = UIColor.darkGray
    open var toastBackgroundColor: UIColor = UIColor.white
    open var toastCornerRadius: CGFloat = 4
    
    public override init() {
        super.init()
        self.resetToDefault() // Initialise default theme.
    }
    
    open func resetToDefault() {
        alertCornerRadius = 0
        titleFont = UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
        bodyFont = UIFont.systemFont(ofSize: 13, weight: UIFontWeightRegular)
        buttonFont = UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
        textfieldFont = UIFont.systemFont(ofSize: 17, weight: UIFontWeightRegular)
        titleTextColor = UIColor(red: 0/255, green: 127/255, blue: 163/255, alpha: 1)
        bodyTextColor = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1)
        standardButtonTextColor = UIColor(red: 0/255, green: 127/255, blue: 163/255, alpha: 1)
        destructiveButtonTextColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        alertWindowBackgroundColor = UIColor.black.withAlphaComponent(0.4)
        submissiveButtonTextColor = UIColor(red: 156/255, green: 189/255, blue: 35/255, alpha: 1)
        separatorColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        textfieldBorderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        checkboxBackgroundColor = UIColor.white
        titleTextAlignment = .left
        bodyTextAlignment = .left
        defaultButtonHeight = 44
        defaultTextFieldHeight = 48
        bodyLineSpacing = 4
        toastFont = UIFont.systemFont(ofSize: 13)
        toastTextColor = UIColor.darkGray
        toastBackgroundColor = UIColor.white
        toastCornerRadius = 4
    }
}

@objc public protocol MSAlertControllerThemableComponent: NSObjectProtocol {
    @objc func applyTheme(_ theme: MSAlertControllerTheme)
}
