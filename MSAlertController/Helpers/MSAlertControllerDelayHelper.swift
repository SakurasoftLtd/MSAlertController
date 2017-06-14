//
//  MSAlertControllerDelayHelper.swift
//  MSAlertController
//
//  Created by Jacob King on 22/02/2017.
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

import Foundation

private class MSAlertControllerDelayHelper {
    
    fileprivate var timer: Timer!
    fileprivate var actionHandler: (() -> Void)?
    
    init(delayAction action: @escaping (() -> Void), byDuration duration: TimeInterval) {
        self.actionHandler = action
        self.timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(MSAlertControllerDelayHelper.delayReached), userInfo: nil, repeats: false)
    }
    
    @objc fileprivate func delayReached() {
        self.timer.invalidate()
        self.timer = nil
        self.actionHandler?()
    }
}

@discardableResult
internal func delay(_ action: @escaping (() -> Void), byDuration duration: TimeInterval) -> Timer {
    return MSAlertControllerDelayHelper(delayAction: action, byDuration: duration).timer
}

@discardableResult
internal func delay(_ action: @escaping (() -> Void), untilDate date: Date) -> Timer {
    let components = (Calendar.current as NSCalendar).components(.second, from: Date(), to: date, options: [])
    let secondsUntilAction = components.second
    return delay(action, byDuration: TimeInterval(secondsUntilAction!))
}
