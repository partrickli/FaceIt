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
            // add gesture recognizer for face view scale change
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changeScale(_:))))
            
            updateUI()
        }
    }
    
    private func updateUI() {
        switch expression.eyes {
        case .open:
            faceView.eyesOpen = true
        case .closed:
            faceView.eyesOpen = false
        case .squinting:
            faceView.eyesOpen = false
        }
    }
    
}

