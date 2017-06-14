//
//  PMGAlertControllerCheckboxComponent.swift
//  PMGAlertController
//
//  Created by Jacob King on 18/01/2017.
//  Copyright © 2017 Parkmobile Group. All rights reserved.
//

import UIKit

open class PMGAlertControllerCheckboxComponent: PMGAlertControllerComponent, PMGAlertControllerThemableComponent {
    
    @IBOutlet private var checkboxView: UIView!
    @IBOutlet private var checkboxLabel: UILabel!
    @IBOutlet private var toggleButton: UIButton!
    
    private var untickedImage = UIImage(named: "IconCheckboxUnticked.png", in: Bundle(identifier: "com.pmg.PMGAlertController"), compatibleWith: nil)
    private var tickedImage = UIImage(named: "IconCheckboxTicked.png", in: Bundle(identifier: "com.pmg.PMGAlertController"), compatibleWith: nil)
    
    private var tick: UIImageView!
    
    private var toggleAction: ((_ sender: UIButton, _ checkboxIsTicked: Bool) -> Void)!
    
    open func applyTheme(_ theme: PMGAlertControllerTheme) {
        checkboxView.backgroundColor = theme.checkboxBackgroundColor
        checkboxLabel.font = theme.bodyFont
        checkboxLabel.textColor = theme.bodyTextColor
    }
    
    @IBAction private func toggleButtonPressed(_ sender: Any) {
        if checkboxView.tag == 1 { hideTick() } else { showTick() }
        self.toggleAction(sender as! UIButton, checkboxView.tag == 1)
    }
    
    internal static func empty() -> PMGAlertControllerCheckboxComponent {
        let selfFromNib = UINib(nibName: "PMGAlertControllerCheckboxComponent", bundle: Bundle(identifier: "com.pmg.PMGAlertController")).instantiate(withOwner: nil, options: nil).first as! PMGAlertControllerCheckboxComponent
        selfFromNib.translatesAutoresizingMaskIntoConstraints = false
        selfFromNib.checkboxView.translatesAutoresizingMaskIntoConstraints = false
        selfFromNib.checkboxLabel.translatesAutoresizingMaskIntoConstraints = false
        selfFromNib.toggleButton.translatesAutoresizingMaskIntoConstraints = false
        selfFromNib.tick = UIImageView(frame: selfFromNib.checkboxView.frame)
        selfFromNib.tick.image = selfFromNib.untickedImage
        selfFromNib.tick.translatesAutoresizingMaskIntoConstraints = false
        selfFromNib.checkboxView.addSubview(selfFromNib.tick)
        selfFromNib.tick.pinToSuperview()
        selfFromNib.checkboxView.layoutIfNeeded()
        selfFromNib.checkboxView.tag = 0
        return selfFromNib
    }
    
    open static func withText(_ text: String, defaultStateIsTicked: Bool, toggleAction: @escaping ((_ sender: UIButton, _ checkboxIsTicked: Bool) -> Void)) -> PMGAlertControllerCheckboxComponent {
        let base = empty()
        base.toggleAction = toggleAction
        base.checkboxLabel.text = text
        if defaultStateIsTicked { base.showTick() } else { base.hideTick() }
        return base
    }
    
    open static func withText(_ text: String, onImage: UIImage, offImage: UIImage, defaultStateIsTicked: Bool, toggleAction: @escaping ((_ sender: UIButton, _ checkboxIsTicked: Bool) -> Void)) -> PMGAlertControllerCheckboxComponent {
        let base = withText(text, defaultStateIsTicked: defaultStateIsTicked, toggleAction: toggleAction)
        base.untickedImage = offImage
        base.tickedImage = onImage
        base.tick.image = base.untickedImage
        return base
    }
    
    open static func withCustomConfiguration(_ configHandler: @escaping ((_ checkbox: UIView) -> Void)) -> PMGAlertControllerCheckboxComponent {
        let base = empty()
        configHandler(base.checkboxView)
        return base
    }
    
    private func showTick() {
        guard !(checkboxView.tag == 1) else {
            hideTick()
            showTick()
            return
        }
        tick.image = tickedImage
        checkboxView.tag = 1
    }
    
    private func hideTick() {
        guard checkboxView.tag == 1 else {
            return
        }
        tick.image = untickedImage
        checkboxView.tag = 0
    }
}
