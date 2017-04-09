//
//  MenuView.swift
//  Papa Poppa
//
//  Created by Charles DiGiovanna on 4/4/17.
//  Copyright © 2017 Charles DiGiovanna. All rights reserved.
//

import UIKit

// @ANNIKA

class MenuView: UIView {

    var button: UIButton!
    var gc: GameViewController?
    
    init(gc gcIn: GameViewController) {
        gc = gcIn
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.button.setTitle("Reset", for:[])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}
