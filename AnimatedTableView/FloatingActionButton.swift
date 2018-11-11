//
//  FloatingActionButton.swift
//  AnimatedTableView
//
//  Created by Tony Cheng on 10/11/2018.
//  Copyright © 2018 tychengaf. All rights reserved.
//

import UIKit

class FloatingActionButton: UIButtonX {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        UIView.animate(withDuration: 0.3, animations: {
            if self.transform == .identity{
            self.transform = CGAffineTransform(rotationAngle: 45 * (.pi/180))
                self.backgroundColor = #colorLiteral(red: 0.8196, green: 0.2196, blue: 0.3333, alpha: 1) /* #d13855 */
        } else {
            self.transform = .identity
                self.backgroundColor = #colorLiteral(red: 0.9412, green: 0.251, blue: 0.3843, alpha: 1) /* #f04062 */
            }
            
        })
        
        return super.beginTracking(touch, with: event)
    }
    
}
