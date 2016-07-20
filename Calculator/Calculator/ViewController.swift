//
//  ViewController.swift
//  Calculator
//
//  Created by Serjo on 19/07/16.
//  Copyright © 2016 Serjo. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(sender: UIButton) {
        guard let digit = sender.currentTitle else {
            return
        }
        
        if(userIsInTheMiddleOfTyping){
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
        
        print("Touched \(digit)")
        
    }
    
    @IBAction func performOperation(sender: UIButton) {
        if let symbol = sender.currentTitle {
            if (symbol == "∏"){
                display.text = String(M_PI)
            }
        }
    }
}

