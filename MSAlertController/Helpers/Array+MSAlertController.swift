//
//  Array+MSAlertController.swift
//  MSAlertController
//
//  Created by Jacob King on 20/07/2017.
//  Copyright © 2017 Parkmobile Group. All rights reserved.
//

import Foundation

internal extension Array where Element: Equatable {
    
    mutating func removeObject(_ object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
    
    func elementAfter(_ element: Element) -> Element? {
        if let indexOfGivenElement = index(of: element) {
            if count > indexOfGivenElement + 1 {
                return self[indexOfGivenElement + 1]
            }
        }
        return nil
    }
    
    func elementBefore(_ element: Element) -> Element? {
        if let indexOfGivenElement = index(of: element) {
            if indexOfGivenElement > 0 {
                return self[indexOfGivenElement - 1]
            }
        }
        return nil
    }
}
