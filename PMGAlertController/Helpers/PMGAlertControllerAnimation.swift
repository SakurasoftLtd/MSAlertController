//
//  PMGAlertControllerAnimation.swift
//  PMGAlertController
//
//  Created by Jacob King on 17/01/2017.
//  Copyright © 2017 Parkmobile Group. All rights reserved.
//

import Foundation

@objc public enum PMGAlertControllerShowAnimation: Int {
    case none = 0
    case fade = 1
    case slideCentre = 2
}

@objc public enum PMGAlertControllerHideAnimation: Int {
    case none = 0
    case fade = 1
    case slideCentre = 2
}
