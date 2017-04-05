//
//  GameViewController.swift
//  Papa Poppa
//
//  Created by Charles DiGiovanna on 4/4/17.
//  Copyright © 2017 Charles DiGiovanna. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    @IBOutlet var level_label: UILabel!
    @IBOutlet var best_label: UILabel!
    var waiting_for_start = false // should be true once menu is implemented
    var level: Level?
    var bubbles_drawn = 0
    var bubbles_tapped = 0
    var score: Int16 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initialization code move to viewDidAppear since it depends on view size
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadLevel {
            print("level loaded wooooooooooooooooo")
            if self.waiting_for_start {
                self.presentMenuScreen()
            } else {
                self.beginLevel()
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Personal
    
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
    
    func setLabels() {
        level_label.text = "Level: \(level!.number)"
        best_label.text = "\(level!.best)"
    }
    
    func presentMenuScreen() {
        // presents a MenuView which should have a background with an alpha value of 0.3-0.7
        // MenuView should be fed the parameter `self.level` perhaps with a convenience init declared in the class
    }
    
    func beginLevel() {
        setLabels()
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
            var frame = BubbleButton.generateRandomFrame(in: self.view!.frame)
            print("gere")
            while frame.intersectsAnyOf(bubbles) {
                frame = BubbleButton.generateRandomFrame(in: self.view!.frame)
            }
            print("richard")
            let bubble = BubbleButton(frame: frame, vc: self, withDurationBetween: durationRange)
            print("aaaaaaaaaaaaaaaaaaaaaaaaand")
            view!.addSubview(bubble)
            print(bubble.frame)
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
}
