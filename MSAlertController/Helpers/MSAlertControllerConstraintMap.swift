//
//  MSAlertControllerConstraintMap.swift
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
