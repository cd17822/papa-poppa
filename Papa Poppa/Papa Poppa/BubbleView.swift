//
//  BubbleView.swift
//  Papa Poppa
//
//  Created by Charles DiGiovanna on 4/4/17.
//  Copyright © 2017 Charles DiGiovanna. All rights reserved.
//

import UIKit
import AVFoundation

// BUBBLES

class BubbleView: UIControl {
    var vc: GameViewController?
    var duration: Int?
    var spawn_time: DispatchTime?
    var popped = false
    var score: Int16 {
        let goal = spawn_time!.uptimeNanoseconds + UInt64(duration!) * UInt64(1e9)
        print(goal)
        print(DispatchTime.now().uptimeNanoseconds)
        var difference: UInt64
        
        if DispatchTime.now().uptimeNanoseconds > goal {
            difference = 0
        } else {
            difference = goal - DispatchTime.now().uptimeNanoseconds
        }
        
        let score = difference / UInt64(1e7)
        
        return Int16(score)
    }
    @IBOutlet var label: UILabel!
    @IBOutlet var content_view: UIView!
    var popSound: AVAudioPlayer!
    
    override func awakeFromNib() {
        print("awkeFromNib")
    }
    
    convenience init(frame: CGRect, vc vcIn: GameViewController, withDurationBetween durationRange: [Int]) {
        self.init(frame: frame)
        
        vc = vcIn
        duration = random(min: durationRange[0], max: durationRange[1])
        
        layer.cornerRadius = frame.width / 2
        
        label.text = "\(duration!)"
        label.font = label.font.withSize(label.font.pointSize + CGFloat(duration!) * 3)
        
        
        createGradient()
        startPopTimer()
    }
    
    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        self.loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        self.loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("BubbleView", owner: self, options: nil)
        guard let content = content_view else { return }
        content.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:))))
        content.frame = self.bounds
        self.addSubview(content)
    }
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        popped = true
        let path = Bundle.main.path(forResource: "pop.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            popSound = sound
            sound.play()
        } catch {
            print("shit")
        }
        print("touched")
        self.vc?.registerBubblePop(score: score)
        removeFromSuperview()
    }
    
    func createGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        gradient.colors = [UIColor.white.cgColor, UIColor.bubbleBlue.cgColor]
        self.clipsToBounds = true
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    static func generateRandomFrame(in bounds: CGRect) -> CGRect {
        let width = random(min: 90.0, max: 120.0)
        let height = width
        let x = random(min: bounds.minX, max: bounds.maxX - width)
        let y = random(min: bounds.minY, max: bounds.maxY - height)

        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func startPopTimer() {
        spawn_time = DispatchTime.now()
        let deadlineTime = DispatchTime.now() + .seconds(duration!)
        
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            if !self.popped {
                self.vc!.registerBubblePop(score: POPPED_SCORE)
                self.removeFromSuperview()
            }
        }
    }
}
