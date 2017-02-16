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
	var scale: CGFloat = 0.90
	var lineWidth: CGFloat = 5.0

 	private var skullRadius: CGFloat {
		return min(bounds.size.width, bounds.size.height) / 2 * scale
	}
 	private var skullCenter: CGPoint {
		return CGPoint(x: bounds.midX, y: bounds.midY) 
	}

	private struct Ratios {
		static let SkullRadiusToEyeOffset: CGFloat = 3
		static let SkullRadiusToEyeRadius: CGFloat = 10
		static let SkullRadiusToMouthWidth: CGFloat = 1
		static let SkullRadiusToMouthHeight: CGFloat = 3
		static let SkullRadiusToMouthOffset: CGFloat = 3
	}

    
	/// helper function for generating UIBezierPath of circle
    /// line width set
	///
	/// - Parameters:
	///   - center: circle center
	///   - radius: circle radius
	/// - Returns: UIBezierPath for circle
	func pathForCircleCenteredAt(_ center: CGPoint, withRadius radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: false)
        path.lineWidth = lineWidth
        return path
	}

    /// Eye
    ///
    /// - left: left eye
    /// - right: right eye
    enum Eye {
        case left
        case right
    }
    
    func pathFor(eye: Eye) -> UIBezierPath {
        
        var eyeX = skullCenter.x
        switch eye {
        case .left:
            eyeX -= skullRadius / Ratios.SkullRadiusToEyeOffset
        case .right:
            eyeX += skullRadius / Ratios.SkullRadiusToEyeOffset
        }
        
        let eyeY = skullCenter.y - skullRadius / Ratios.SkullRadiusToEyeOffset
        
        let eyeCenter = CGPoint(x: eyeX, y: eyeY)
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        
        let path = pathForCircleCenteredAt(eyeCenter, withRadius: eyeRadius)
        path.lineWidth = lineWidth
        return path
    }
    
    internal override func draw(_ rect: CGRect) {
        UIColor.blue.set()
        pathForCircleCenteredAt(skullCenter, withRadius: skullRadius).stroke()
        let eyes: [Eye] = [.left, .right]
        eyes.forEach {
            pathFor(eye: $0).stroke()
        }
    }

}
