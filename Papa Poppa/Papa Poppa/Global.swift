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



// MARK: - Global functions

func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
}

func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
}

func random(min: Int, max: Int) -> Int {
    return Int(random()) * (max - min) + min
}

// MARK: - Extensions

extension UIColor {
    static var bubbleBlue: UIColor {
        return UIColor(red:0.67, green:0.93, blue:0.99, alpha:1.00)
    }
}

extension Level {
    convenience init(_ number: Int16, _ best: Int16 = 0) {
        self.init()
        
        self.number = number
        self.best = best
    }
}

extension CGRect {
    func intersectsAnyOf(_ otherViews: [UIView]) -> Bool {
        for b in otherViews {
            if self.intersects(b.frame) {
                return true
            }
        }
        
        return false
    }
}
