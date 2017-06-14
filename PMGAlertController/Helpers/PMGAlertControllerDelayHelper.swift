//
//  PMGAlertControllerDelayHelper.swift
//  PMGAlertController
//
//  Created by Jacob King on 22/02/2017.
//  Copyright © 2017 Parkmobile Group. All rights reserved.
//

import Foundation

private class PMGAlertControllerDelayHelper {
    
    fileprivate var timer: Timer!
    fileprivate var actionHandler: (() -> Void)?
    
    init(delayAction action: @escaping (() -> Void), byDuration duration: TimeInterval) {
        self.actionHandler = action
        self.timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(PMGAlertControllerDelayHelper.delayReached), userInfo: nil, repeats: false)
    }
    
    @objc fileprivate func delayReached() {
        self.timer.invalidate()
        self.timer = nil
        self.actionHandler?()
    }
}

@discardableResult
internal func delay(_ action: @escaping (() -> Void), byDuration duration: TimeInterval) -> Timer {
    return PMGAlertControllerDelayHelper(delayAction: action, byDuration: duration).timer
}

@discardableResult
internal func delay(_ action: @escaping (() -> Void), untilDate date: Date) -> Timer {
    let components = (Calendar.current as NSCalendar).components(.second, from: Date(), to: date, options: [])
    let secondsUntilAction = components.second
    return delay(action, byDuration: TimeInterval(secondsUntilAction!))
}
