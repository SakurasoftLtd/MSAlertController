//
//  KeyboardEventHelper.swift
//  PMGAlertController
//
//  Created by Jacob King on 04/04/2017.
//  Copyright © 2017 Parkmobile Group. All rights reserved.
//

import Foundation
import UIKit

internal protocol KeyboardListener {
    func keyboardWillShow(_ notification: Notification)
    func keyboardDidShow(_ notification: Notification)
    func keyboardWillHide(_ notification: Notification)
    func keyboardDidHide(_ notification: Notification)
    
    func subscribeToKeyboardEvents() throws
    func unsubscribeFromKeyboardEvents() throws
}

internal extension KeyboardListener {
    func keyboardWillShow(_ notification: Notification) { }
    func keyboardDidShow(_ notification: Notification) { }
    func keyboardWillHide(_ notification: Notification) { }
    func keyboardDidHide(_ notification: Notification) { }
    
    func subscribeToKeyboardEvents() throws {
        if let object = self as? AnyObject {
            if object.responds(to: "keyboardWillShow:") {
                NotificationCenter.default.addObserver(object, selector: "keyboardWillShow:", name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            }
            if object.responds(to: "keyboardDidShow:") {
                NotificationCenter.default.addObserver(object, selector: "keyboardDidShow:", name: NSNotification.Name.UIKeyboardDidShow, object: nil)
            }
            if object.responds(to: "keyboardWillHide:") {
                NotificationCenter.default.addObserver(object, selector: "keyboardWillHide:", name: NSNotification.Name.UIKeyboardWillHide, object: nil)
            }
            if object.responds(to: "keyboardDidHide:") {
                NotificationCenter.default.addObserver(object, selector: "keyboardDidHide:", name: NSNotification.Name.UIKeyboardDidHide, object: nil)
            }
            return
        }
        throw KeyboardHelperError.invalidConformanceToAnyObject
    }
    
    func unsubscribeFromKeyboardEvents() throws {
        if let object = self as? AnyObject {
            NotificationCenter.default.removeObserver(object, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.removeObserver(object, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
            NotificationCenter.default.removeObserver(object, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
            NotificationCenter.default.removeObserver(object, name: NSNotification.Name.UIKeyboardDidHide, object: nil)
            return
        }
        throw KeyboardHelperError.invalidConformanceToAnyObject
    }
}

internal enum KeyboardHelperError: Error {
    case invalidConformanceToAnyObject
}
