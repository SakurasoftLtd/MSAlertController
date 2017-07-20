//
//  MSToastController.swift
//  MSAlertController
//
//  Created by Jacob King on 22/02/2017.
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

open class MSToastController: UIViewController {
    
    @IBOutlet private var label: UILabel!
    
    var window: UIWindow!
    var previousWindow: UIWindow?
    
    public var text: String {
        get {
            return label.text ?? ""
        }
        set {
            label.text = newValue
        }
    }
    
    fileprivate var dismissAutomatically: Bool = false;
    
    open static var masterTheme: MSAlertControllerTheme = MSAlertControllerTheme()
    open var theme: MSAlertControllerTheme = MSAlertController.masterTheme
    
    open var onDismiss: (() -> Void)?
    
    open static func withText(_ text: String) -> MSToastController {
        let selfFromNib = UINib(nibName: "MSToastController", bundle: Bundle(identifier: "uk.co.militiasoftworks.msalertcontroller")).instantiate(withOwner: nil, options: nil).first as! MSToastController
        selfFromNib.label.text = text
        return selfFromNib
    }
    
    open static func withAttributedText(_ text: NSAttributedString) -> MSToastController {
        let selfFromNib = UINib(nibName: "MSToastController", bundle: Bundle(identifier: "uk.co.militiasoftworks.msalertcontroller")).instantiate(withOwner: nil, options: nil).first as! MSToastController
        selfFromNib.label.attributedText = text
        return selfFromNib
    }
    
    private func configure() {
        
        // Configure window
        self.window = UIWindow(frame: UIApplication.shared.keyWindow!.bounds)
        self.window.windowLevel = UIWindowLevelAlert
        self.window.backgroundColor = UIColor.clear
        self.window.rootViewController = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissToast)))
    }
    
    internal func applyTheme(theme: MSAlertControllerTheme) {
        
        // TODO: Apply theme to self.
        
        self.view.backgroundColor = theme.toastBackgroundColor
        self.view.layer.cornerRadius = theme.toastCornerRadius
        self.view.layer.masksToBounds = theme.toastCornerRadius > 0
        self.label.textColor = theme.toastTextColor
        self.label.font = theme.toastFont
        
        self.theme = theme
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Adjust sizing, we want it to be 85% the width of the screen.)
        
        let maximumLabelSize = CGSize(width: UIScreen.main.bounds.width * 0.85, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = label.sizeThatFits(maximumLabelSize)
        
        label.frame = CGRect(origin: CGPoint.zero, size: labelSize)
        self.window.frame = CGRect(x: UIScreen.main.bounds.midX - (label.bounds.width / 2), y: UIScreen.main.bounds.maxY - 60 - (label.bounds.height + 32), width: label.bounds.width + 32, height: label.bounds.height + 32)
        self.window.center = CGPoint(x: UIScreen.main.bounds.midX, y: self.window.center.y)
        self.label.center = self.view.center
        
        // This will cause any user specified constraints to be set.
        self.applyTheme(theme: self.theme)
    }
    
    open func showToast(autoDismissAfterDuration dismissDelay: Double = 2) {
        // Shows the alert
        if window == nil {
            configure()
        }
        self.applyTheme(theme: self.theme)
        self.previousWindow = UIApplication.shared.keyWindow
        self.window.layoutIfNeeded()
        
        self.view.alpha = 0
        self.window.makeKeyAndVisible()
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.view.alpha = 1
        }, completion: nil)
        
        if dismissDelay > 0 {
            delay(dismissToast, byDuration: dismissDelay)
        }
    }
    
    open func dismissToast() {
        // Pass control back to the apps window.
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0
        }) { (done) in
            self.previousWindow?.makeKeyAndVisible()
            self.window = nil
            self.onDismiss?()
        }
    }
}
