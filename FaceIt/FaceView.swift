//
//  FaceView.swift
//  FaceIt
//
//  Created by liguiyan on 2017/2/15.
//  Copyright © 2017年 partrick. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {
    override func draw(_ rect: CGRect) {
 		let skullRadius = min(bounds.size.width, bounds.size.height) / 2
		let skullCenter = CGPoint(x: bounds.midX, y: bounds.midY) 
		let skull = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: 2 * .pi, clockwise: false)
        skull.lineWidth = 5.0
        UIColor.blue.set()
        skull.stroke()
    }

}
