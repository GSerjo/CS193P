//
//  ViewController.swift
//  Calculator
//
//  Created by Serjo on 14/08/15.
//  Copyright © 2015 Serjo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    private var userIsInTheMiddleOfTypingANumber = false
    private var userAddedFloatingPoint = false
    private var brain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayValue = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func appendDigit(sender: UIButton) {
        appendNumber(sender.currentTitle!)
    }
    
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        userAddedFloatingPoint = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        }
        else {
            displayValue = 0
        }
    }
    
    @IBAction func addFloatingPoint(sender: UIButton) {
        if userAddedFloatingPoint {
            return
        }
        appendNumber(sender.currentTitle!)
        userAddedFloatingPoint = true
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            }
            else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func clearAll() {
        brain = CalculatorBrain()
        displayValue = 0
    }
    
    private func appendNumber(symbol: String) {
        
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + symbol
        }
        else {
            display.text = symbol
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    var displayValue: Double{
        get{
            let formatter = NSNumberFormatter()
            formatter.locale = NSLocale(localeIdentifier: "en_US")
            return formatter.numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

