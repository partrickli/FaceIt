//
//  ExpressionEditorViewController.swift
//  FaceIt
//
//  Created by liguiyan on 2017/4/18.
//  Copyright © 2017年 partrick. All rights reserved.
//

import UIKit

class ExpressionEditorViewController: UITableViewController {
    
    // keep track of UI
    var name: String {
        return nameTextField.text ?? "nil"
    }
    
    // expression
    let eyeOptions: [FacialExpression.Eyes] = [.open, .closed, .squinting]
    let mouthOptions: [FacialExpression.Mouth] = [.frown, .smirk, .neutral, .grin, .smile]
    
    var expression: FacialExpression {
        return FacialExpression(
            eyes: eyeOptions[eyeControl?.selectedSegmentIndex ?? 0],
            eyeBrows: FacialExpression.EyeBrows.normal,
            mouth: mouthOptions[mouthControl?.selectedSegmentIndex ?? 0])
    }


    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mouthControl: UISegmentedControl!
    @IBOutlet weak var eyeControl: UISegmentedControl!
    
    @IBAction func updateFace() {
        print("\(name) = \(expression)")
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return tableView.bounds.size.width
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
}
