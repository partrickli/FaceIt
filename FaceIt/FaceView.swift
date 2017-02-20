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

    @IBInspectable
	var color: UIColor = UIColor.blue
    @IBInspectable
	var scale: CGFloat = 0.90
	var lineWidth: CGFloat = 5.0
    @IBInspectable
    var mouthCurvature: Double = 0.5 // 1 full smile, -1 full frown

    @IBInspectable
    var eyeBrowTilt: Double = 0.5 // 1 full relax, -1 full frown

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
        static let SkullRadiusToBrowOffset: CGFloat = 4
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
    
    func getEyeCenter(eye: Eye) -> CGPoint {
 
        var eyeX = skullCenter.x
        switch eye {
        case .left:
            eyeX -= skullRadius / Ratios.SkullRadiusToEyeOffset
        case .right:
            eyeX += skullRadius / Ratios.SkullRadiusToEyeOffset
        }
        let eyeY = skullCenter.y - skullRadius / Ratios.SkullRadiusToEyeOffset
        return CGPoint(x: eyeX, y: eyeY)
	}
        
    /// UIBezierPath for Eyes
    ///
    /// - Parameter eye: left or right eye
    /// - Returns: path for specified eye
    func pathFor(eye: Eye) -> UIBezierPath {
        
        
        /// <#Description#>
        let eyeCenter = getEyeCenter(eye: eye)
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        
        let path = pathForCircleCenteredAt(eyeCenter, withRadius: eyeRadius)
        path.lineWidth = lineWidth
        return path
    }
    
    /// UIBezierPath for mouth curvature.
    var pathForMouth: UIBezierPath {
        
        let mouthWidth = skullRadius / Ratios.SkullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.SkullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.SkullRadiusToMouthOffset
        
        let mouthRect = CGRect(
            x: skullCenter.x - mouthWidth / 2,
            y: skullCenter.y + mouthOffset,
            width: mouthWidth,
            height: mouthHeight
        )
        
        let smileOffset = CGFloat(min(max(mouthCurvature, -1), 1)) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let control1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        let control2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)
		let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
		let path = UIBezierPath()
		path.move(to: start)
        path.addCurve(to: end, controlPoint1: control1, controlPoint2: control2)
		
        path.lineWidth = lineWidth
        return path
    }
    
	private func pathForBrow(eye: Eye) -> UIBezierPath {
		var tilt = eyeBrowTilt
		switch eye {
		case .left:
			 tilt *= -1.0
		case .right:
			 break
		}
        var browCenter = getEyeCenter(eye: eye)
		browCenter.y -= skullRadius / Ratios.SkullRadiusToBrowOffset
		let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
		let tiltOffset = CGFloat(max(-1, min(tilt, 1))) * eyeRadius / 2
		let browStart = CGPoint(x: browCenter.x - eyeRadius, y: browCenter.y - tiltOffset)
		let browEnd = CGPoint(x: browCenter.x + eyeRadius, y: browCenter.y + tiltOffset)
		let path = UIBezierPath()
        path.move(to: browStart)
        path.addLine(to: browEnd)
		path.lineWidth = lineWidth
		return path
	}

    internal override func draw(_ rect: CGRect) {
        color.set()
        pathForCircleCenteredAt(skullCenter, withRadius: skullRadius).stroke()
        let eyes: [Eye] = [.left, .right]
        eyes.forEach {
            pathFor(eye: $0).stroke()
            pathForBrow(eye: $0).stroke()
        }
        pathForMouth.stroke()
    }

}
