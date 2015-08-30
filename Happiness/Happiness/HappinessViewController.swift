//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Serjo on 29/08/15.
//  Copyright © 2015 Serjo. All rights reserved.
//

import UIKit

final class HappinessViewController: UIViewController, FaceViewDataSource {
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
        }
    }

    // 0 = very sad, 100 = esctatic
    var happiness: Int = 100 {
        didSet {
            happiness = min(max(happiness, 0), 100)
            print("happiness = \(happiness)")
            updateUI()
        }
    }
    
    func updateUI() {
        faceView.setNeedsDisplay()
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50)/50
    }

}
