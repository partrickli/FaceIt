//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by liguiyan on 2017/2/23.
//  Copyright © 2017年 partrick. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    private let facialExpressioins: [String: FacialExpression] = [
        "happy": FacialExpression(eyes: .open, eyeBrows: .relaxed, mouth: .smile),
        "angry": FacialExpression(eyes: .open, eyeBrows: .furrowed , mouth: .frown),
        "mischievious": FacialExpression(eyes: .closed, eyeBrows: .normal, mouth: .smile),
        "worried": FacialExpression(eyes: .closed, eyeBrows: .furrowed, mouth: .neutral)
    ]

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationVC = segue.destination
        if let navigationVC = destinationVC as? UINavigationController {
            destinationVC = navigationVC.visibleViewController ?? destinationVC
        }
        if let faceVC = destinationVC as? FaceViewController,
            let segueIdentifier = segue.identifier,
            let expression = facialExpressioins[segueIdentifier] {
            
            faceVC.expression = expression
            if let button = sender as? UIButton {
                faceVC.navigationItem.title = button.currentTitle
            }
        }
    }
}
