//
//  PMGToastController.swift
//  PMGAlertController
//
//  Created by Jacob King on 22/02/2017.
//  Copyright © 2017 Parkmobile Group. All rights reserved.
//

import UIKit

open class PMGToastController: UIViewController {
    
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
    
    open static var masterTheme: PMGAlertControllerTheme = PMGAlertControllerTheme()
    open var theme: PMGAlertControllerTheme = PMGAlertController.masterTheme
    
    open var onDismiss: (() -> Void)?
    
    open static func withText(_ text: String) -> PMGToastController {
        let selfFromNib = UINib(nibName: "PMGToastController", bundle: Bundle(identifier: "com.pmg.PMGAlertController")).instantiate(withOwner: nil, options: nil).first as! PMGToastController
        selfFromNib.label.text = text
        return selfFromNib
    }
    
    open static func withAttributedText(_ text: NSAttributedString) -> PMGToastController {
        let selfFromNib = UINib(nibName: "PMGToastController", bundle: Bundle(identifier: "com.pmg.PMGAlertController")).instantiate(withOwner: nil, options: nil).first as! PMGToastController
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
    
    internal func applyTheme(theme: PMGAlertControllerTheme) {
        
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
