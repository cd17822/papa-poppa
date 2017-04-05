//
//  BubbleButton.swift
//  Papa Poppa
//
//  Created by Charles DiGiovanna on 4/4/17.
//  Copyright © 2017 Charles DiGiovanna. All rights reserved.
//

import UIKit

class BubbleButton: UIButton {
    var scene: GameScene?
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
    
    convenience init(frame: CGRect, scene: GameScene, withDurationBetween durationRange: [Int]) {
        self.init(frame: frame)
        
        print("this should print second")
        self.scene = scene
        self.duration = random(min: durationRange[0], max: durationRange[1])
        self.spawn_time = Date.init(timeIntervalSinceNow: 0)
        
        startPopTimer()
    }
    
    override func draw(_ rect: CGRect) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [UIColor.white.cgColor, UIColor.bubbleBlue.cgColor]
        self.titleLabel!.text = "\(duration ?? -1)"
    }
    
    @IBAction func touchUpInside(_ sender: Any) {
        popped = true
        
        self.scene?.registerBubblePop(score: score)
        removeFromSuperview()
    }
    
    static func generateRandomFrame (in viewBounds: CGRect) -> CGRect {
        let width = random(min: 50.0, max: 70.0)
        let height = width
        let x = random(min: viewBounds.minX, max: viewBounds.maxX - width)
        let y = random(min: viewBounds.minY, max: viewBounds.maxY - height)
        print("yeah it's the view i guess")
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func startPopTimer() {
        let deadlineTime = DispatchTime.now() + .seconds(duration!)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            if !self.popped {
                self.scene?.registerBubblePop(score: self.score)
                self.removeFromSuperview()
            }
        }
    }
}
