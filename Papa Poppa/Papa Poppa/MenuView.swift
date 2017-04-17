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
    var nextLevelButton: UIButton!
    var retryLevelButton: UIButton!

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
//        label = UILabel(frame: CGRect(x: 12, y: 8, width: self.frame.size.width-90, height: 50))
//        label.text = "Retry level"
//        label.textColor = UIColor.white
//        label.numberOfLines = 0
//        label.font = UIFont.systemFont(ofSize: 14)
//        self.addSubview(label)
        
        nextLevelButton = UIButton(frame: CGRect(x: self.frame.size.width-87, y: 8, width: 86, height: 50))
        nextLevelButton.setTitle("Next Level", for: UIControlState.normal)
        nextLevelButton.setTitleColor(UIColor(red: 76/255, green: 175/255, blue: 80/255, alpha: 1.0), for: UIControlState.normal)
        nextLevelButton.addTarget(self, action: #selector(MenuView.nextLevel(_:)), for: UIControlEvents.touchDown)
        self.addSubview(nextLevelButton)
        
        retryLevelButton = UIButton(frame: CGRect(x: self.frame.size.width-87, y: 8, width: 86, height: 50))
        retryLevelButton.setTitle("Retry Level", for: UIControlState.normal)
        retryLevelButton.setTitleColor(UIColor(red: 76/255, green: 175/255, blue: 80/255, alpha: 1.0), for: UIControlState.normal)
        retryLevelButton.addTarget(self, action: #selector(MenuView.retryLevel(_:)), for: UIControlEvents.touchDown)
        self.addSubview(retryLevelButton)
    }
    
    func nextLevel(_ sender: UITapGestureRecognizer) {
        print("switchLevelButtonPressed")
        nextLevelButton.setTitleColor(UIColor.red, for: UIControlState.normal)
//        removeFromSuperview()
    }
    
    func retryLevel(_ sender: UITapGestureRecognizer) {
        print("nextLevelButtonPressed")
        nextLevelButton.setTitleColor(UIColor.red, for: UIControlState.normal)
        //        removeFromSuperview()
    }
}
