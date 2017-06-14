//
//  MSAlertControllerEmbedComponent.swift
//  MSAlertController
//
//  Created by Jacob King on 18/01/2017.
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

open class MSAlertControllerEmbedComponent: MSAlertControllerComponent {
    
    open static func withEmbeddedView(_ view: UIView, andFixedHeight height: CGFloat) -> MSAlertControllerEmbedComponent {
        let base = MSAlertControllerEmbedComponent(frame: CGRect.zero)
        base.addSubview(view)
        let constraints = view.pinToSuperview()
        view.translatesAutoresizingMaskIntoConstraints = false
        base.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height))
        base.leftConstraint = constraints?.left
        base.rightConstraint = constraints?.right
        base.topConstraint = constraints?.top
        base.bottomConstraint = constraints?.bottom
        base.layoutIfNeeded()
        return base
    }
}
