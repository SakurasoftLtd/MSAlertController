//
//  MSAlertControllerEmbedComponent.swift
//  MSAlertController
//
//  Created by Jacob King on 18/01/2017.
//  Copyright © 2017 Militia Softworks Ltd. All rights reserved.
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
