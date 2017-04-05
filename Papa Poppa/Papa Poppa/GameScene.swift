//
//  GameScene.swift
//  Papa Poppa
//
//  Created by Charles DiGiovanna on 4/4/17.
//  Copyright © 2017 Charles DiGiovanna. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var waitingForStart = false // should be true once menu is implemented
    var level: Level?
    var view_controller: GameViewController?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadLevel {
            if self.waitingForStart {
                self.presentMenuScreen()
            } else {
                self.beginLevel()
            }
        }
    }
    
    func loadLevel(_ cb: (() -> ())) {
        CoreDataHandler.getLevel { level, error in
            if error != nil {
                print(error!)
            }
            
            self.level = level
            
            cb()
        }
    }
    
    func presentMenuScreen() {
        // presents a MenuView which should have a background with an alpha value of 0.3-0.7
        // MenuView should be fed the parameter `self.level` perhaps with a convenience init declared in the class
    }
    
    func beginLevel() {
        view_controller!.setLabels(level: level!)
        generateBubbles()
    }
    
    func generateLevels() {
        
    }
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
