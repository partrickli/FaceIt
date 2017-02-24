//
//  ViewController.swift
//  FaceIt
//
//  Created by liguiyan on 2017/2/15.
//  Copyright © 2017年 partrick. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    
    var expression = FacialExpression(eyes: .open, eyeBrows: .relaxed, mouth: .smile) {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            // add pinch gesture recognizer to change face view scale accordingly
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changeScale(_:))))
            
            // swipe gesture recognizer to change mouth
            let happierRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FaceViewController.happier))
            happierRecognizer.direction = .up
            faceView.addGestureRecognizer(happierRecognizer)
            
            let sadderRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FaceViewController.sadder))
            sadderRecognizer.direction = .down
            faceView.addGestureRecognizer(sadderRecognizer)
            
            // tap gesture recognizer to blink eye
            let blinkEyeRecognizer = UITapGestureRecognizer(target: self, action: #selector(FaceViewController.blinkEye))
            faceView.addGestureRecognizer(blinkEyeRecognizer)
            
            // pan gesture recognizer to change eye brow angle
            let eyebrowRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(FaceViewController.moveEyebrow(_:)))
            faceView.addGestureRecognizer(eyebrowRecognizer)
            //update UI
            updateUI()

        }
    }
    
    func moveEyebrow(_ recognizer: UIRotationGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            expression.eyeBrows = recognizer.rotation > 0 ? expression.eyeBrows.moreRelaxed : expression.eyeBrows.moreFurrowed
        default:
            break
        }
    }
    //happier gesture recognizer handler
    func happier() {
        expression.mouth = expression.mouth.happier
    }
    
    //sadder gesture recognizer handler
    func sadder() {
        expression.mouth = expression.mouth.sadder
    }
    
    func blinkEye() {
        expression.eyes.toggle()
    }

    let mouthCuvatures: [FacialExpression.Mouth: Double] = [
        .frown: -1.0,
        .smirk: -0.5,
        .neutral: 0,
        .grin: 0.5,
        .smile: 1
    ]
    
    let eyeBrowTilts: [FacialExpression.EyeBrows: Double] = [
        .relaxed: 1,
        .normal: 0,
        .furrowed: -1
    ]
    
    private func updateUI() {
        
        switch expression.eyes {
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        case .squinting:
            faceView?.eyesOpen = false
        }
        
        faceView?.mouthCurvature = mouthCuvatures[expression.mouth] ?? 0
        
        faceView?.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0
    }
    
}

