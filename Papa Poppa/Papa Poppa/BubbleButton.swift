//
//  BubbleButton.swift
//  Papa Poppa
//
//  Created by Charles DiGiovanna on 4/4/17.
//  Copyright © 2017 Charles DiGiovanna. All rights reserved.
//

import UIKit

class BubbleButton: UIButton {
    var vc: GameViewController?
    var duration: Int?
    var spawn_time: Date?
    var popped = false
    var score: Int16 {
        let now = Date.init(timeIntervalSinceNow: 0)
        return Int16(now.compare(spawn_time!).rawValue)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, vc: GameViewController, withDurationBetween durationRange: [Int]) {
        self.init(frame: frame)
        
        self.createGradient()
        
        print("this should print second")
        self.vc = vc
        self.duration = random(min: durationRange[0], max: durationRange[1])
        self.spawn_time = Date.init(timeIntervalSinceNow: 0)
        
        self.setTitle("\(duration ?? -1)", for: .normal)
        
        startPopTimer()
    }
    
    func createGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [UIColor.white.cgColor, UIColor.bubbleBlue.cgColor]
        
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    @IBAction func touchUpInside(_ sender: Any) {
        popped = true
        print("touched")
        self.vc?.registerBubblePop(score: score)
        removeFromSuperview()
    }
    
    static func generateRandomFrame(in bounds: CGRect) -> CGRect {
        let width = random(min: 50.0, max: 70.0)
        let height = width
        let x = random(min: bounds.minX, max: bounds.maxX - width)
        let y = random(min: bounds.minY, max: bounds.maxY - height)
        print("yeah it's the view i guess")
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func startPopTimer() {
        let deadlineTime = DispatchTime.now() + .seconds(duration!)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            if !self.popped {
                self.vc!.registerBubblePop(score: self.score)
                self.removeFromSuperview()
            }
        }
    }
}
