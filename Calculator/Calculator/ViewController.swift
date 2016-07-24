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
    
    private var brain = CalculatorBrain()
    private var userIsInTheMiddleOfTyping = false
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
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
    }
    
    @IBAction func performOperation(sender: UIButton) {
        
        if(userIsInTheMiddleOfTyping){
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.perforOperation(mathematicalSymbol)
        }
        
        displayValue = brain.result
    }
}

