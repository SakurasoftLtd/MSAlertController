//
//  MSAlertControllerAnimation.swift
//  MSAlertController
//
//  Created by Jacob King on 17/01/2017.
//  Copyright © 2017 Militia Softworks Ltd. All rights reserved.
//

import Foundation

@objc public enum MSAlertControllerShowAnimation: Int {
    case none = 0
    case fade = 1
    case slideCentre = 2
}

@objc public enum MSAlertControllerHideAnimation: Int {
    case none = 0
    case fade = 1
    case slideCentre = 2
}
