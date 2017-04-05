//
//  BubbleButton.swift
//  Papa Poppa
//
//  Created by Charles DiGiovanna on 4/4/17.
//  Copyright © 2017 Charles DiGiovanna. All rights reserved.
//

import UIKit

class BubbleButton: UIButton {
    override func draw(_ rect: CGRect) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.bubbleBlue.cgColor]
    }
}
