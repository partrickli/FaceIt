//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by liguiyan on 2017/2/23.
//  Copyright © 2017年 partrick. All rights reserved.
//

import UIKit

class EmotionsViewController: UITableViewController {

    private var emotionalFaces: [(name: String, expression: FacialExpression)] = [
        ("happy", FacialExpression(eyes: .open, eyeBrows: .relaxed, mouth: .smile)),
        ("angry", FacialExpression(eyes: .open, eyeBrows: .furrowed , mouth: .frown)),
        ("mischievious", FacialExpression(eyes: .closed, eyeBrows: .normal, mouth: .smile))
    ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationVC = segue.destination
        if let navigationVC = destinationVC as? UINavigationController {
            destinationVC = navigationVC.visibleViewController ?? destinationVC
        }
        if let faceVC = destinationVC as? FaceViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            
            faceVC.expression = emotionalFaces[indexPath.row].expression
            faceVC.navigationItem.title = emotionalFaces[indexPath.row].name

        }
    }
    
    //table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emotionalFaces.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmotionCell", for: indexPath)
        cell.textLabel?.text = emotionalFaces[indexPath.row].name
        return cell
    }
    
    // modal view controller 
    @IBAction func addEmotionFace(from segue: UIStoryboardSegue) {
        if let editor = segue.source as? ExpressionEditorViewController {
            emotionalFaces.append((name: editor.name, expression: editor.expression))
            tableView.reloadData()
        }
    }
    
}
