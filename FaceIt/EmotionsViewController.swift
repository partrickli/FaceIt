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
        guard let faceVC = segue.destination as? FaceViewController else {
            return
        }
        if let segueIdentifier = segue.identifier, let expression = facialExpressioins[segueIdentifier] {
            faceVC.expression = expression
        }
    }
}
