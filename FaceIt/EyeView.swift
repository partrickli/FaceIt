//
//  EyeView.swift
//  FaceIt
//
//  Created by liguiyan on 2017/4/12.
//  Copyright © 2017年 partrick. All rights reserved.
//

import UIKit

@IBDesignable
class EyeView: UIView {
    @IBInspectable
    var lineWidth: CGFloat = 5.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var color: UIColor = .blue {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var _eyesOpen: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var eyesOpen: Bool {
        get {
            return _eyesOpen
        }
        set {
            if newValue != _eyesOpen {
                UIView.transition(with: self, duration: 0.4, options: [.transitionFlipFromTop], animations: {
                    self._eyesOpen = newValue
                })
            }
        }
    }


    override func draw(_ rect: CGRect) {
        var path: UIBezierPath
        if eyesOpen {
            path = UIBezierPath(ovalIn: bounds.insetBy(dx: lineWidth / 2, dy: lineWidth / 2))
        } else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.minX, y: bounds.midY))
            path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.midY))
        }
        
        path.lineWidth = lineWidth
        color.set()
        path.stroke()
    }

}
