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
    @IBOutlet weak var history: UILabel!
    
    private var userIsInTheMiddleOfTypingANumber = false
    private var brain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayValue = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func appendDigit(sender: UIButton) {
        appendDigitSymbol(sender.currentTitle!)
    }
    
    
    @IBAction func enter() {
        
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        }
        else {
            displayValue = 0
        }
    }
    
    @IBAction func addFloatingPoint(sender: UIButton) {
        let symbol = sender.currentTitle!
        if display.text?.rangeOfString(symbol) == nil {
            appendDigitSymbol(symbol)
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
                history.text = history.text! + "="
            }
            else {
                displayValue = 0
                history.text = history.text! + "ERROR"
            }
        }
    }
    
    @IBAction func backspace() {
        if userIsInTheMiddleOfTypingANumber == false {
            return
        }
        let displayText = display.text!
        
        if displayText.characters.count < 1 {
            return
        }
        
        display.text = displayText.substringToIndex(displayText.endIndex.predecessor())
        
        if display.text!.characters.count < 1 {
            displayValue = 0
        }
    }
    
    @IBAction func clearAll() {
        brain = CalculatorBrain()
        displayValue = 0
    }
    
    private func appendDigitSymbol(symbol: String) {
        
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
            history.text = brain.displayStack
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

