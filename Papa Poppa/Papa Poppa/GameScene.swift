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
    var waiting_for_start = false // should be true once menu is implemented
    var level: Level?
    var view_controller: GameViewController?
    var bubbles_drawn = 0
    var bubbles_tapped = 0
    var score: Int16 = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadLevel {
            if self.waiting_for_start {
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
    
    func generateBubbles() {
        switch level!.number {
        case 1:
            drawBubbles(amount: 1, withDurationBetween: [3,6])
        default:
            level = Level(1)
            generateBubbles()
        }
    }
    
    func drawBubbles(amount: Int, withDurationBetween durationRange: [Int]) {
        bubbles_drawn = amount
        let bubbles = [BubbleButton]()
        
        for _ in 0..<amount {
            var frame = BubbleButton.generateRandomFrame(in: view!.frame)
            
            while frame.intersectsAnyOf(bubbles) {
                frame = BubbleButton.generateRandomFrame(in: view!.frame)
            }
         
            let bubble = BubbleButton(frame: frame, scene: self, withDurationBetween: durationRange)
            
            self.view!.addSubview(bubble)
        }
    }
    
    func registerBubblePop(score: Int16) {
        self.score += score
        self.bubbles_tapped += 1
        
        if self.bubbles_tapped == self.bubbles_drawn {
            concludeLevel()
        }
        
    }
    
    func concludeLevel() {
        let level_to_save = Level(level!.number, score)
        CoreDataHandler.save(level: level_to_save) {
            self.presentMenuScreen()
        }
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
