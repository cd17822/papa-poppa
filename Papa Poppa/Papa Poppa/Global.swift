//
//  Global.swift
//  Papa Poppa
//
//  Created by Charles DiGiovanna on 4/4/17.
//  Copyright © 2017 Charles DiGiovanna. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// MARK: - Global variables

let POPPED_SCORE: Int16 = 250 // this is the really shitty score you get it if you let one pop
var gameNotStarted = true
// MARK: - Global functions

func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
}

func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
}

func random(min: Int, max: Int) -> Int {
    return Int(random(min: CGFloat(min), max: CGFloat(max)))
}

// MARK: - Extensions

extension UIColor {
    static var bubbleBlue: UIColor {
        return UIColor(red:0.67, green:0.93, blue:0.99, alpha:1.00)
    }
}

extension CGRect {
    func intersectsAnyOf(_ otherViews: [UIView]) -> Bool {
        for v in otherViews {
            if self.intersects(v.frame) {
                print(self)
                print(v.frame)
                return true
            }
        }
        
        return false
    }
}
