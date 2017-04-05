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
    var bubbles_drawn = 0
    var bubbles_tapped = 0
    var score: Int16 = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadLevel {
            print("level loaded wooooooooooooooooo")
            if self.waiting_for_start {
                self.presentMenuScreen()
            } else {
                self.beginLevel()
            }
        }
    }
    
    func loadLevel(_ cb: @escaping (() -> ())) {
        CoreDataHandler.getCurrentLevel { level, error in
            if error != nil {
                print(error!)
            }
            print("------------got current level")
            self.level = level
            
            cb()
        }
    }
    
    func presentMenuScreen() {
        // presents a MenuView which should have a background with an alpha value of 0.3-0.7
        // MenuView should be fed the parameter `self.level` perhaps with a convenience init declared in the class
    }
    
    func beginLevel() {
        GAME_VIEW_CONTROLLER!.setLabels(level: level!)
        generateBubbles()
    }
    
    func generateBubbles() {
        print("looking for level nooooooooooooooooo")
        switch level!.number {
        case 1:
            drawBubbles(amount: 1, withDurationBetween: [3,6])
        default:
            level = CoreDataHandler.default_level_1
            generateBubbles()
        }
    }
    
    func drawBubbles(amount: Int, withDurationBetween durationRange: [Int]) {
        bubbles_drawn = amount
        let bubbles = [BubbleButton]()
        print("gere1")
        for _ in 0..<amount {
            var frame = BubbleButton.generateRandomFrame(in: GAME_VIEW_CONTROLLER!.view!.frame)
            print("gere")
            while frame.intersectsAnyOf(bubbles) {
                frame = BubbleButton.generateRandomFrame(in: GAME_VIEW_CONTROLLER!.view!.frame)
            }
            print("richard")
            let bubble = BubbleButton(frame: frame, scene: self, withDurationBetween: durationRange)
            print("aaaaaaaaaaaaaaaaaaaaaaaaand")
            GAME_VIEW_CONTROLLER!.view!.addSubview(bubble)
            print("not here")
        }
        print("bubbles drawn")
    }
    
    func registerBubblePop(score: Int16) {
        self.score += score
        self.bubbles_tapped += 1
        print("popped")
        if self.bubbles_tapped == self.bubbles_drawn {
            concludeLevel()
        }
        
    }
    
    func concludeLevel() {
        CoreDataHandler.save(level: level!) { error in
            if error != nil {
                print(error!)
            }
            print("levelsaved")
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
