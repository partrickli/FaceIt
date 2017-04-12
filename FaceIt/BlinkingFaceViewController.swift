//
//  BlinkingFaceViewController.swift
//  FaceIt
//
//  Created by liguiyan on 2017/4/12.
//  Copyright © 2017年 partrick. All rights reserved.
//

import UIKit

class BlinkingFaceViewController: FaceViewController {
    var isBlinking: Bool = false {
        didSet {
            blinkIfNeeded()
        }
    }
    
    private struct BlinkRate {
        static let closedDuration: TimeInterval = 0.4
        static let openDuration: TimeInterval = 2.5
    }
    
    private func blinkIfNeeded() {
        guard isBlinking else {
            return
        }
        faceView.eyesOpen = false
        Timer.scheduledTimer(withTimeInterval: BlinkRate.closedDuration, repeats: false) { [weak self] _ in
            self?.faceView.eyesOpen = true
            Timer.scheduledTimer(withTimeInterval: BlinkRate.openDuration, repeats: false) { [weak self] _ in
                self?.blinkIfNeeded()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isBlinking = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isBlinking = false
    }
}
