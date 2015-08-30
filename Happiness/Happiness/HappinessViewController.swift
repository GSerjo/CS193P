//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Serjo on 29/08/15.
//  Copyright © 2015 Serjo. All rights reserved.
//

import UIKit

final class HappinessViewController: UIViewController {

    // 0 = very sad, 100 = esctatic
    var happiness: Int = 50 {
        didSet {
            happiness = min(max(happiness, 0), 100)
            print("happiness = \(happiness)")
            updateUI()
        }
    }
    
    func updateUI() {
        
    }

}
