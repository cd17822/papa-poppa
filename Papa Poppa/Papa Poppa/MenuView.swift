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
    var level: Level?

    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
    }
    
    convenience init(frame: CGRect, vc vcIn: GameViewController, levelIn: Level) {
        self.init(frame: frame)
        vc = vcIn
        self.alpha = 0.3
        level = levelIn
        
        nextLevelButton = UIButton(frame: CGRect(x: self.frame.size.width/2, y: (self.frame.size.height/2)-100, width: 100, height: 50))
        nextLevelButton.setTitle("Next Level", for: UIControlState.normal)
        nextLevelButton.setTitleColor(UIColor.white.withAlphaComponent(1.0), for: UIControlState.normal)
        nextLevelButton.addTarget(self, action: #selector(MenuView.nextLevel(_:)), for: UIControlEvents.touchDown)
        self.addSubview(nextLevelButton)
        
        retryLevelButton = UIButton(frame: CGRect(x: self.frame.size.width/2, y: self.frame.size.height/2, width: 100, height: 50))
        retryLevelButton.setTitle("Retry Level", for: UIControlState.normal)
        retryLevelButton.setTitleColor(UIColor.white.withAlphaComponent(1.0), for: UIControlState.normal)
        retryLevelButton.addTarget(self, action: #selector(MenuView.retryLevel(_:)), for: UIControlEvents.touchDown)
        self.addSubview(retryLevelButton)
    }
    
    func nextLevel(_ sender: UITapGestureRecognizer) {
        print("switchLevelButtonPressed")
        level?.number += 1
        vc?.beginLevel()
        removeFromSuperview()
    }
    
    func retryLevel(_ sender: UITapGestureRecognizer) {
        print("nextLevelButtonPressed")
        vc?.beginLevel()
        retryLevelButton.setTitleColor(UIColor.red, for: UIControlState.normal)
        removeFromSuperview()
    }
}
