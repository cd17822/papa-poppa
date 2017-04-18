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
    var lastScoreLabel: UILabel!
    var startButton: UIButton!
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
        self.alpha = 0.5
        level = levelIn
        
//        lastScoreLabel = UILabel(frame: CGRect(x: (self.frame.size.width/2)-50, y: 10, width: 100, height: 50))
//        lastScoreLabel.textColor = UIColor.white.withAlphaComponent(1.0)
//        lastScoreLabel.text = "Papa"
    
        if(level?.number == 1){
            startButton = UIButton(frame: CGRect(x: (self.frame.size.width/2)-50, y: (self.frame.size.height/2)-150, width: 100, height: 50))
            startButton.setTitle("Start", for: UIControlState.normal)
            startButton.setTitleColor(UIColor.white.withAlphaComponent(1.0), for: UIControlState.normal)
            startButton.layer.cornerRadius = 4
            //nextLevelButton.backgroundColor = UIColor.clear
            startButton.layer.borderColor = UIColor.white.cgColor
            startButton.layer.borderWidth = 2
            startButton.addTarget(self, action: #selector(MenuView.nextLevel(_:)), for: UIControlEvents.touchDown)
            self.addSubview(startButton)
        }
        else{
                nextLevelButton = UIButton(frame: CGRect(x: (self.frame.size.width/2)-50, y: (self.frame.size.height/2)-150, width: 100, height: 50))
                nextLevelButton.setTitle("Next Level", for: UIControlState.normal)
                nextLevelButton.setTitleColor(UIColor.white.withAlphaComponent(1.0), for: UIControlState.normal)
                nextLevelButton.layer.cornerRadius = 4
                //nextLevelButton.backgroundColor = UIColor.clear
                nextLevelButton.layer.borderColor = UIColor.white.cgColor
                nextLevelButton.layer.borderWidth = 2
                nextLevelButton.addTarget(self, action: #selector(MenuView.nextLevel(_:)), for: UIControlEvents.touchDown)
                self.addSubview(nextLevelButton)
            
                retryLevelButton = UIButton(frame: CGRect(x: (self.frame.size.width/2)-50, y: (self.frame.size.height/2)-95, width: 100, height: 50))
                retryLevelButton.setTitle("Retry Level", for: UIControlState.normal)
                retryLevelButton.setTitleColor(UIColor.white.withAlphaComponent(1.0), for: UIControlState.normal)
                retryLevelButton.layer.cornerRadius = 4
                //nextLevelButton.backgroundColor = UIColor.clear
                retryLevelButton.layer.borderColor = UIColor.white.cgColor
                retryLevelButton.layer.borderWidth = 2
                retryLevelButton.addTarget(self, action: #selector(MenuView.retryLevel(_:)), for: UIControlEvents.touchDown)
                self.addSubview(retryLevelButton)

        }

    }
    
    func nextLevel(_ sender: UITapGestureRecognizer) {
        print("switchLevelButtonPressed")
        CoreDataHandler.makeCurrentLevel((self.level?.number)! + 1) { error in vc?.beginLevel() }
//        vc?.beginLevel()
        self.removeFromSuperview()
        
    }
    
    func retryLevel(_ sender: UITapGestureRecognizer) {
        print("nextLevelButtonPressed")
        vc?.beginLevel()
        removeFromSuperview()
    }
}
