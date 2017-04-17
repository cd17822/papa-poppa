//
//  MenuView.swift
//  Papa Poppa
//
//  Created by Charles DiGiovanna on 4/4/17.
//  Copyright © 2017 Charles DiGiovanna. All rights reserved.
//

import UIKit
import SpriteKit

// @ANNIKA

class MenuView: UIView {
    var vc: GameViewController?
    var label: UILabel!
    var button: UIButton!

    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
    }
    
    convenience init(frame: CGRect, vc vcIn: GameViewController) {
        self.init(frame: frame)
        
        vc = vcIn
        
        //layer.cornerRadius = frame.width / 2
        self.backgroundColor = UIColor.green
        //label.setTitle("yo", for: UIControlState.normal)
        label = UILabel(frame: CGRect(x: 12, y: 8, width: self.frame.size.width-90, height: 50))
        label.text = "Connection error please try again later!!"
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(label)
        
        button = UIButton(frame: CGRect(x: self.frame.size.width-87, y: 8, width: 86, height: 50))
        button.setTitle("OK", for: UIControlState.normal)
        button.setTitleColor(UIColor(red: 76/255, green: 175/255, blue: 80/255, alpha: 1.0), for: UIControlState.normal)
        button.setTitleColor(UIColor.red, for:UIControlState.highlighted)
        self.addSubview(button)
    }
}
