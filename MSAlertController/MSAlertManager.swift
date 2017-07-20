//
//  MSAlertManager.swift
//  MSAlertController
//
//  Created by Jacob King on 20/07/2017.
//  Copyright © 2017 Parkmobile Group. All rights reserved.
//

import Foundation

// MARK: Configure UINavigationController to send a notification upon popping view controllers.

private let NavigationControllerDidPopViewControllerNotification = "NavigationControllerDidPopViewControllerNotification"

private let swizzling: (UINavigationController.Type) -> () = { nav in
    let originalSelector = #selector(nav.popViewController(animated:))
    let swizzledSelector = #selector(nav.extendedPopViewController(animated:))
    
    let originalMethod = class_getInstanceMethod(nav, originalSelector)
    let swizzledMethod = class_getInstanceMethod(nav, swizzledSelector)
    
    method_exchangeImplementations(originalMethod, swizzledMethod)
}

public extension UINavigationController {
    
    open override class func initialize() {
        guard self === UINavigationController.self else {
            return
        }
        swizzling(self)
    }
    
    func extendedPopViewController(animated: Bool) -> UIViewController? {
        let vc = self.extendedPopViewController(animated: animated) // Not infinite loop as methods have been switched.
        NotificationCenter.default.post(name: NSNotification.Name(NavigationControllerDidPopViewControllerNotification), object: vc)
        return vc
    }
}

// MARK: Helper enums.

public enum MSAlertType {
    case information
    case error
    case notification
}

public enum MSAlertPriority {
    case normal
    case critical
}

public enum MSAlertActionType {
    case standard
    case submissive
    case destructive
}

// MARK: Alert Manager

open class MSAlertManager: NSObject {
    
    open static let shared = MSAlertManager()
    
    internal var queuedAlerts = [UIViewController]()
    internal var alertsToQueueOnPop = [UIViewController]()
    
    internal var currentlyDisplayedAlert: UIViewController?
    open var queueLocked: Bool = false
    
    open var defaultShowAnimation: MSAlertControllerShowAnimation = .slideCentre
    open var defaultHideAnimation: MSAlertControllerHideAnimation = .slideCentre
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(navigationControllerDidPopViewController(notification:)), name: NSNotification.Name(NavigationControllerDidPopViewControllerNotification), object: nil)
    }
    
    open func navigationControllerDidPopViewController(notification: Notification) {
        for alert in alertsToQueueOnPop {
            queuedAlerts.append(alert)
            alertWasAddedToQueue()
            alertsToQueueOnPop.removeObject(alert)
        }
    }
    
    fileprivate func alertWasAddedToQueue() {
        guard currentlyDisplayedAlert == nil else {
            return
        }
        // As no alert is visible, we can show one, if one is available.
        guard let alert = queuedAlerts.first else {
            return
        }
        
        queuedAlerts.remove(at: 0)
        if let alert = alert as? MSAlertController {
            alert.showAlert(withAnimation: self.defaultShowAnimation)
            currentlyDisplayedAlert = alert
            return
        }
        if let toast = alert as? MSToastController {
            toast.showToast()
            currentlyDisplayedAlert = alert
            return
        }
    }
    
    fileprivate func alertWasDismissed() {
        currentlyDisplayedAlert = nil
        
        // See if there is another alert to show.
        guard let alert = queuedAlerts.first else {
            return
        }
        
        queuedAlerts.remove(at: 0)
        if let alert = alert as? MSAlertController {
            alert.showAlert(withAnimation: self.defaultShowAnimation)
            currentlyDisplayedAlert = alert
            return
        }
        if let toast = alert as? MSToastController {
            toast.showToast()
            currentlyDisplayedAlert = alert
            return
        }
    }
}

// MARK: Alert queue helpers.

extension MSAlertManager {
    
    open func queueAlert(_ alert: MSAlertController) {
        guard !queueLocked else {
            return
        }
        queuedAlerts.append(alert)
        alertWasAddedToQueue()
    }
    
    open func queueAlert(withTitle title: String, message: String, type: MSAlertType) {
        queueAlert(withTitle: title, message: message, dismissButtonTitle: nil, onDismiss: nil, type: type, priority: .normal)
    }
    
    open func queueAlert(withTitle title: String, message: String, type: MSAlertType, priority: MSAlertPriority) {
        queueAlert(withTitle: title, message: message, dismissButtonTitle: nil, onDismiss: nil, type: type, priority: priority)
    }
    
    open func queueAlert(withTitle title: String, message: String, dismissButtonTitle: String?, onDismiss:(() -> Void)?, type: MSAlertType, priority: MSAlertPriority) {
        
        guard !queueLocked else {
            return
        }
        
        switch type {
        case .notification:
            let toast = MSToastController.withText(message)
            toast.onDismiss = alertWasDismissed
            
            // Check if this toast message already exists in queue, as we dont want multiple for the same message
            if !checkForDuplicateMessage(withMessage: message) {
                if priority == .critical {
                    queuedAlerts.insert(toast, at: 0)
                } else {
                    queuedAlerts.append(toast)
                }
            }
        default:
            let alert = buildStandardAlert(title: title, body: message, buttonTitle: dismissButtonTitle ?? "Okay", buttonAction: onDismiss)
            if priority == .critical {
                queuedAlerts.insert(alert, at: 0)
            } else {
                queuedAlerts.append(alert)
            }
        }
        alertWasAddedToQueue()
    }
    
    open func queueAlertOnPop(_ alert: MSAlertController) {
        guard !queueLocked else {
            return
        }
        alertsToQueueOnPop.append(alert)
    }
    
    open func queueAlertOnPop(withTitle title: String, message: String, type: MSAlertType) {
        queueAlertOnPop(withTitle: title, message: message, dismissButtonTitle: nil, onDismiss: nil, type: type, priority: .normal)
    }
    
    open func queueAlertOnPop(withTitle title: String, message: String, type: MSAlertType, priority: MSAlertPriority) {
        queueAlertOnPop(withTitle: title, message: message, dismissButtonTitle: nil, onDismiss: nil, type: type, priority: priority)
    }
    
    open func queueAlertOnPop(withTitle title: String, message: String, dismissButtonTitle: String?, onDismiss:(() -> Void)?, type: MSAlertType, priority: MSAlertPriority) {
        
        guard !queueLocked else {
            return
        }
        
        switch type {
        case .notification:
            let toast = MSToastController.withText(message)
            toast.onDismiss = alertWasDismissed
            if priority == .critical {
                alertsToQueueOnPop.insert(toast, at: 0)
            } else {
                alertsToQueueOnPop.append(toast)
            }
        default:
            let alert = buildStandardAlert(title: title, body: message, buttonTitle: dismissButtonTitle ?? "Okay", buttonAction: onDismiss)
            if priority == .critical {
                alertsToQueueOnPop.insert(alert, at: 0)
            } else {
                alertsToQueueOnPop.append(alert)
            }
        }
    }
    
    internal func checkForDuplicateMessage(withMessage message: String) -> Bool {
        for alert in queuedAlerts {
            if let toast = alert as? MSToastController {
                return toast.text == message
            }
        }
        
        return false
    }
    
    internal func buildStandardAlert(title: String, body: String, buttonTitle: String, buttonAction: (() -> Void)?) -> MSAlertController {
        let alert = MSAlertController.empty()
        
        let titleComponent = MSAlertControllerTitleComponent.withTitleText(title)
        
        let bodyComponent = MSAlertControllerBodyComponent.withBodyText(body)
        
        let buttonComponent = MSAlertControllerButtonComponent.submissiveButtonWithText(buttonTitle) { (sender) in
            alert.dismissAlert(withAnimation: self.defaultHideAnimation) { self.alertWasDismissed() }
            buttonAction?()
        }
        
        titleComponent.applyConstraintMap(MSAlertControllerConstraintMap(top: 16, bottom: 8, left: 16, right: 16, height: 0))
        bodyComponent.applyConstraintMap(MSAlertControllerConstraintMap(top: 8, bottom: 16, left: 16, right: 16, height: 0))
        alert.components = [titleComponent, bodyComponent, buttonComponent]
        
        return alert
    }
}
