//
//  PMGAlertController.swift
//  PMGAlertController
//
//  Created by Jacob King on 13/01/2017.
//  Copyright © 2017 Parkmobile Group. All rights reserved.
//

import UIKit
import CoreGraphics
import QuartzCore

public typealias PMGAlertControllerButtonComponentAction = ((_ sender: Any, _ alert: PMGAlertController) -> Void)

internal class PMGAlertWindow: UIWindow {
    override var frame: CGRect {
        didSet {
            let screenBounds = UIScreen.main.bounds
            guard frame == screenBounds else {
                frame = screenBounds
                return
            }
        }
    }
}

open class PMGAlertController: UIViewController, UITableViewDataSource, UITableViewDelegate, KeyboardListener {
    
    @IBOutlet internal var tableView: UITableView!
    @IBOutlet private var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var tableViewWidthConstraint: NSLayoutConstraint!
    
    open var components: [PMGAlertControllerComponent]!
    var window: PMGAlertWindow!
    var previousWindow: UIWindow?
    
    fileprivate var dismissAutomatically: Bool = false;
    
    open static var masterTheme: PMGAlertControllerTheme = PMGAlertControllerTheme()
    open var theme: PMGAlertControllerTheme = PMGAlertController.masterTheme
    
    // Master init
    open static func empty() -> PMGAlertController {
        let selfFromNib = UINib(nibName: "PMGAlertController", bundle: Bundle(identifier: "com.pmg.PMGAlertController")).instantiate(withOwner: nil, options: nil).first as! PMGAlertController
        selfFromNib.configure()
        return selfFromNib
    }
    
    open static func withComponents(_ components: [PMGAlertControllerComponent]) -> PMGAlertController {
        let selfFromNib = empty()
        selfFromNib.components = components
        return selfFromNib
    }
    
    private func configure() {
        self.components = [PMGAlertControllerComponent]()
        
        // Configure window
        self.window = PMGAlertWindow(frame: UIApplication.shared.keyWindow!.bounds)
        self.window.windowLevel = UIWindowLevelAlert
        self.window.backgroundColor = UIColor.clear
        self.window.rootViewController = self
        
        // Configure table
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorColor = UIColor.clear
        self.tableView.isScrollEnabled = false
        self.tableView.allowsSelection = false
        self.tableView.clipsToBounds = true
    }
    
    internal func applyTheme(theme: PMGAlertControllerTheme) {
        
        // TODO: Apply theme to self.
        // Add shadow
        let path = UIBezierPath(rect: CGRect(origin: tableView.bounds.origin, size: tableView.contentSize))
        tableView.layer.masksToBounds = false
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOffset = CGSize(width: 1, height: 1)
        tableView.layer.shadowOpacity = 0.5
        tableView.layer.shadowPath = path.cgPath
        
        self.view.backgroundColor = theme.alertWindowBackgroundColor
        self.view.layer.cornerRadius = theme.alertCornerRadius
        self.view.layer.masksToBounds = theme.alertCornerRadius > 0
        self.tableView.layer.cornerRadius = theme.alertCornerRadius
        self.tableView.layer.masksToBounds = theme.alertCornerRadius > 0
        
        // And to all components
        for component in components where component.responds(to: #selector(PMGAlertControllerThemableComponent.applyTheme(_:))) {
            (component as! PMGAlertControllerThemableComponent).applyTheme(theme)
        }
        self.theme = theme
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Adjust sizing, we want it to be 85% the width of the screen.
        let screenWidth = self.window.bounds.width
        let alertWidth = screenWidth * 0.85
        self.tableViewWidthConstraint.constant = alertWidth
        
        // This will cause any user specified constraints to be set.
        self.applyTheme(theme: self.theme)
        
        // We need to calculate the height of the tableview based on the components in it.
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        let alertHeight = self.tableView.contentSize.height
        self.tableViewHeightConstraint.constant = alertHeight
        
        self.applyTheme(theme: self.theme) // Reapply theme as table will alter it.
    }
    
    open func showAlert(withAnimation animation: PMGAlertControllerShowAnimation) {
        showAlert(withAnimation: animation, andCompletion: nil)
    }
    
    open func showAlert(withAnimation animation: PMGAlertControllerShowAnimation, andCompletion completion:(() -> Void)?) {
        // Shows the alert
        if window == nil {
            configure()
        }
        self.applyTheme(theme: self.theme)
        self.previousWindow = UIApplication.shared.keyWindow
        self.window.layoutIfNeeded()
        
        switch animation {
        case .none: showNone { completion?() }
        case .fade: showFade { completion?() }
        case .slideCentre: showSlideCentre { completion?() }
        }
        
        try? self.subscribeToKeyboardEvents()
    }
    
    open func dismissAlert(withAnimation animation: PMGAlertControllerHideAnimation) {
        dismissAlert(withAnimation: animation, andCompletion: nil)
    }
    
    open func dismissAlert(withAnimation animation: PMGAlertControllerHideAnimation, andCompletion completion:(() -> Void)?) {
        // Pass control back to the apps window.
        switch animation {
        case .none: hideNone { completion?() }
        case .fade: hideFade { completion?() }
        case .slideCentre: hideSlideCentre { completion?() }
        }
        
        try? self.unsubscribeFromKeyboardEvents()
    }
    
    // MARK: Table related stuff.
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let component = components[indexPath.row]
        cell.contentView.addSubview(component)
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        component.translatesAutoresizingMaskIntoConstraints = false
        component.pinToSuperview()
        return cell
    }
}

// MARK: Keyboard reactions
internal extension PMGAlertController {
    
    func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect, let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        let remainingScreenRealEstateY = UIScreen.main.bounds.height - keyboardHeight
        let yPadding: CGFloat = 16
        let maxAlertHeight = remainingScreenRealEstateY - (yPadding * 2)
        var animationBlock: () -> Void
        
        if self.tableView.contentSize.height >= maxAlertHeight {
            animationBlock = {
                self.tableView.frame = CGRect(x: self.tableView.frame.minX, y: yPadding, width: self.tableView.frame.width, height: maxAlertHeight)
                self.tableView.isScrollEnabled = true
                self.tableView.clipsToBounds = true
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                self.window.layoutIfNeeded()
            }
        } else {
            animationBlock = {
                self.tableView.center = CGPoint(x: self.tableView.center.x, y: remainingScreenRealEstateY / 2)
                self.window.layoutIfNeeded()
            }
        }
        
        UIView.animate(withDuration: animationDuration, animations: animationBlock, completion: { done in
            if self.tableView.isScrollEnabled { self.flashScrollIndicator() }
        })
    }
    
    func keyboardWillHide(_ notification: Notification) {
        guard let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        
        var animationBlock: () -> Void
        
        if tableView.isScrollEnabled {
            animationBlock = {
                self.tableView.isScrollEnabled = false
                self.view.setNeedsLayout()
                self.window.layoutIfNeeded()
            }
        } else {
            animationBlock = {
                self.tableView.center = CGPoint(x: self.tableView.center.x, y: self.window.center.y)
                self.window.layoutIfNeeded()
            }
        }
        
        UIView.animate(withDuration: animationDuration, animations: animationBlock)
    }
    
    private func flashScrollIndicator() {
        self.tableView.flashScrollIndicators()
        delay({
            self.tableView.flashScrollIndicators()
        }, byDuration: 1.5)
    }
}

// MARK: Convenience builders
public extension PMGAlertController {
    
    public static func basicOneButton(title: String, body: String, dismissAutomatically: Bool = true, buttonTitle: String, buttonAction: @escaping PMGAlertControllerButtonComponentAction) -> PMGAlertController {
        let alert = self.empty()
        alert.dismissAutomatically = dismissAutomatically
        
        let titleComponent = PMGAlertControllerTitleComponent.withTitleText(title)
        let bodyComponent = PMGAlertControllerBodyComponent.withBodyText(body)
        let buttonComponent = PMGAlertControllerButtonComponent.standardButtonWithText(buttonTitle) { (sender) in
            if (alert.dismissAutomatically) {
                alert.dismissAlert(withAnimation: .none)
            }
            buttonAction(sender, alert)
        }
        
        titleComponent.applyConstraintMap(PMGAlertControllerConstraintMap(top: 16, bottom: 8, left: 16, right: 16))
        bodyComponent.applyConstraintMap(PMGAlertControllerConstraintMap(top: 8, bottom: 16, left: 16, right: 16))
        
        alert.components = [titleComponent, bodyComponent, buttonComponent]
        return alert
    }
    
    public static func basicTwoButton(title: String, body: String, dismissAutomatically: Bool = true, buttonOneTitle: String, buttonOneAction: @escaping PMGAlertControllerButtonComponentAction, buttonTwoTitle: String, buttonTwoAction: @escaping PMGAlertControllerButtonComponentAction) -> PMGAlertController {
        let alert = self.empty()
        alert.dismissAutomatically = dismissAutomatically

        let titleComponent = PMGAlertControllerTitleComponent.withTitleText(title)
        let bodyComponent = PMGAlertControllerBodyComponent.withBodyText(body)
        let buttonOneComponent = PMGAlertControllerButtonComponent.standardButtonWithText(buttonOneTitle) { (sender) in
            buttonOneAction(sender, alert)
        }
        let buttonTwoComponent = PMGAlertControllerButtonComponent.standardButtonWithText(buttonTwoTitle) { (sender) in
            buttonTwoAction(sender, alert)
        }
        
        titleComponent.applyConstraintMap(PMGAlertControllerConstraintMap(top: 16, bottom: 8, left: 16, right: 16))
        bodyComponent.applyConstraintMap(PMGAlertControllerConstraintMap(top: 8, bottom: 16, left: 16, right: 16))
        
        alert.components = [titleComponent, bodyComponent, buttonOneComponent, buttonTwoComponent]
        return alert
    }
    
    public static func basicTextInput(title: String, body: String, dismissAutomatically: Bool = true, textfieldPlaceholder: String, buttonOneTitle: String, buttonOneAction: @escaping PMGAlertControllerButtonComponentAction, buttonTwoTitle: String, buttonTwoAction: @escaping PMGAlertControllerButtonComponentAction) -> PMGAlertController {
        let alert = empty()
        alert.dismissAutomatically = dismissAutomatically
        
        let titleComponent = PMGAlertControllerTitleComponent.withTitleText(title)
        let bodyComponent = PMGAlertControllerBodyComponent.withBodyText(body)
        let buttonOneComponent = PMGAlertControllerButtonComponent.submissiveButtonWithText(buttonOneTitle) { (sender) in
            if (alert.dismissAutomatically) {
                alert.dismissAlert(withAnimation: .none)
            }
            buttonOneAction(sender, alert)
        }
        let buttonTwoComponent = PMGAlertControllerButtonComponent.standardButtonWithText(buttonTwoTitle) { (sender) in
            if (alert.dismissAutomatically) {
                alert.dismissAlert(withAnimation: .none)
            }
            buttonTwoAction(sender, alert)
        }
        let textfieldComponent = PMGAlertControllerTextFieldComponent.withPlaceholderText(textfieldPlaceholder)
        
        titleComponent.applyConstraintMap(PMGAlertControllerConstraintMap(top: 16, bottom: 8, left: 16, right: 16))
        bodyComponent.applyConstraintMap(PMGAlertControllerConstraintMap(top: 8, bottom: 8, left: 16, right: 16))
        textfieldComponent.applyConstraintMap(PMGAlertControllerConstraintMap(top: 8, bottom: 16, left: 16, right: 16))
        
        alert.components = [titleComponent, bodyComponent, textfieldComponent, buttonOneComponent, buttonTwoComponent]
        return alert
    }
}

// MARK: Animation methods
internal extension PMGAlertController {
    
    internal func showNone(withCompletion completion: (() -> Void)? = nil) {
        self.window.makeKeyAndVisible()
        completion?()
    }
    
    internal func hideNone(withCompletion completion: (() -> Void)? = nil) {
        self.previousWindow?.makeKeyAndVisible()
        self.window = nil
        completion?()
    }
    
    internal func showFade(withCompletion completion: (() -> Void)? = nil) {
        self.view.alpha = 0
        self.window.makeKeyAndVisible()
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: { 
            self.view.alpha = 1
        }, completion: { (done) in
            completion?()
        })
    }
    
    internal func hideFade(withCompletion completion: (() -> Void)? = nil) {
        self.previousWindow?.makeKeyAndVisible()
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0
        }) { (done) in
            self.window = nil
            completion?()
        }
    }
    
    internal func showSlideCentre(withCompletion completion: (() -> Void)? = nil) {
        self.tableView.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.view.backgroundColor = UIColor.clear
        self.window.makeKeyAndVisible()
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.tableView.transform = CGAffineTransform.identity
            self.view.backgroundColor = self.theme.alertWindowBackgroundColor
        }) { (done) in
            completion?()
        }
    }
    
    internal func hideSlideCentre(withCompletion completion: (() -> Void)? = nil) {
        self.previousWindow?.makeKeyAndVisible()
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.tableView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            self.view.backgroundColor = UIColor.clear
        }) { (done) in
            self.window = nil
            completion?()
        }
    }
}
