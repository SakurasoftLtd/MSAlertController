//
//  MSAlertControllerConstraintMap.swift
//  MSAlertController
//
//  Created by Jacob King on 16/01/2017.
//  Copyright © 2017 Militia Softworks Ltd. All rights reserved.
//

import UIKit

open class MSAlertControllerConstraintMap: NSObject {
    open var topInset: CGFloat
    open var bottomInset: CGFloat
    open var leftInset: CGFloat
    open var rightInset: CGFloat
    open var height: CGFloat
    
    public required init(top: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, height: CGFloat = 44) {
        self.topInset = top
        self.bottomInset = bottom
        self.leftInset = left
        self.rightInset = right
        self.height = height
        super.init()
    }
}
