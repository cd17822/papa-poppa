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

// MARK: - Globals variables




// MARK: - Extensions

extension UIColor {
    static var bubbleBlue: UIColor {
        return UIColor(red:0.67, green:0.93, blue:0.99, alpha:1.00)
    }
}

extension Level {
    convenience init(_ number: Int16) {
        self.init()
        
        self.number = number
        self.best = 0
    }
}
