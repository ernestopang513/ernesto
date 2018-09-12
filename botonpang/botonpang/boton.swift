//
//  boton.swift
//  botonpang
//
//  Created by Macbook on 12/09/18.
//  Copyright © 2018 max. All rights reserved.
//

import UIKit

class boton: UIButton {

    override func awakeFromNib() {
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.black.cgColor
        //layer.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        layer.cornerRadius = 9
        
        /*let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 100
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: nil)*/
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash .toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 25, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        let toPoint = CGPoint(x: center.x + 25, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(flash, forKey: nil)
        layer.add(shake, forKey:  nil)
        
    }
}
