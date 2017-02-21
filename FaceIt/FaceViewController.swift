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
            updateUI()
        }
    }
    
    //happier recognizer handler
    func happier() {
        expression.mouth = expression.mouth.happier
    }
    
    //sadder recognizer handler
    func sadder() {
        expression.mouth = expression.mouth.sadder
    }

    let mouthCuvatures: [FacialExpression.Mouth: Double] = [
        .frown: -1.0,
        .smirk: -0.5,
        .neutral: 0,
        .grin: 0.5,
        .smile: 1
    ]
    
    private func updateUI() {
        
        switch expression.eyes {
        case .open:
            faceView.eyesOpen = true
        case .closed:
            faceView.eyesOpen = false
        case .squinting:
            faceView.eyesOpen = false
        }
        
        faceView.mouthCurvature = mouthCuvatures[expression.mouth] ?? 0
    }
    
}

