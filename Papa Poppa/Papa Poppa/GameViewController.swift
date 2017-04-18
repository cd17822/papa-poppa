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

// This is the main screen
// @ANNIKA also if you can make my design any better since I really didn't try with anything, go for it you have all the freedom in the world 🙂
// and if you wanna do something like make the bubbles breathe i was thinking of doing that but it's more annoying than it sounds
// (although it would be cute af)
// and sounds - I've never worked with sounds before but if you wanna add some sound to a bubble popping that would probs be easy
// (but idrc if you do it)

class GameViewController: UIViewController {
    @IBOutlet var level_label: UILabel!
    @IBOutlet var best_label: UILabel!
    @IBOutlet var menuView: UIView!
    
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
            self.presentMenuScreen()
            //self.beginLevel() // this will eventually be commented out when presentMenuScreen is good to go
        }
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

            self.level = level
            
            cb()
        }
    }
    
    func setLabels() {
        level_label.text = "Level: \(level!.number)"
        best_label.text =  "Best: \(level!.best)"
    }
    
    func presentMenuScreen() {
        menuView = MenuView(frame: self.view!.frame, vc: self, levelIn: (self.level)!)
        self.view.addSubview(menuView)

        // @ANNIKA
        // presents a MenuView (see MenuView.swift) which should have a background with an alpha value of 0.3-0.7 DONE
        // MenuView should be fed `self.level` and `self` so that the level info can be presented and methods here can be called DONE
        // there should be two buttons, retry level and next level DONE
        // on top of the buttons maybe just show how you did that last round (number and score) or a welcome screen
        // if retry level is pressed then you just need to call beginLevel() here
        // if next level is pressed then you need to call CoreDataHandler.makeCurrentLevel(self.level.number! + 1) { error in ... }
        // and the dots is where you'll then call beginLevel() here
        // im not positive about the above logic but it seems to make sense to me
    }
    
    func beginLevel() {
        menuView.removeFromSuperview()
        loadLevel {
            self.setLabels()
            self.generateBubbles()
        }
    }
    
    func generateBubbles() {
        // @ANNIKA
        // make these levels differ from each other with some degree of difficulty increase i suppose
        switch level!.number {
        case 1:
            drawBubbles(amount: 2, withDurationBetween: [2,12])
        case 2:
            drawBubbles(amount: 3, withDurationBetween: [2,10])
        case 3:
            drawBubbles(amount: 3, withDurationBetween: [2,9])
        case 4:
            drawBubbles(amount: 3, withDurationBetween: [3,8])
        case 5:
            drawBubbles(amount: 4, withDurationBetween: [3,6])
        case 6:
            drawBubbles(amount: 4, withDurationBetween: [4,6])
        case 7:
            drawBubbles(amount: 5, withDurationBetween: [2,4])
        case 8:
            drawBubbles(amount: 5, withDurationBetween: [3,7])
        case 9:
            drawBubbles(amount: 5, withDurationBetween: [3,5])
        case 10:
            drawBubbles(amount: 6, withDurationBetween: [3,4])
        default:
            print("Error: level number is not 1-10")
        }
    }
    
    func drawBubbles(amount: Int, withDurationBetween durationRange: [Int]) {
        bubbles_drawn = amount
        var bubbles = [BubbleView]()
    
        for _ in 0..<amount {
            var frame = BubbleView.generateRandomFrame(in: self.view!.frame)
            while frame.intersectsAnyOf(bubbles) {
                frame = BubbleView.generateRandomFrame(in: self.view!.frame)
            }
            
            let bubble = BubbleView(frame: frame, vc: self, withDurationBetween: durationRange)
            
            view!.addSubview(bubble)
            bubbles.append(bubble)
        }
    }
    
    func registerBubblePop(score: Int16) {
        self.score += score
        self.bubbles_tapped += 1
        print("score: \(score)")
        if self.bubbles_tapped == self.bubbles_drawn {
            concludeLevel()
        }
    }
    
    func concludeLevel() {
        level!.best = max(score, level!.best)
        CoreDataHandler.save(level: level!) { error in
            if error != nil {
                print(error!)
            }
            self.presentMenuScreen()
        }
    }
}
