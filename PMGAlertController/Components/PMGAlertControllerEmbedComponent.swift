//
//  PMGAlertControllerEmbedComponent.swift
//  PMGAlertController
//
//  Created by Jacob King on 18/01/2017.
//  Copyright © 2017 Parkmobile Group. All rights reserved.
//

import UIKit

open class PMGAlertControllerEmbedComponent: PMGAlertControllerComponent {
    
    open static func withEmbeddedView(_ view: UIView, andFixedHeight height: CGFloat) -> PMGAlertControllerEmbedComponent {
        let base = PMGAlertControllerEmbedComponent(frame: CGRect.zero)
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
