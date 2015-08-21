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
    private let minus = "-"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayValue = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func appendDigit(sender: UIButton) {
        appendDigitSymbol(sender.currentTitle!)
    }
    
    
    @IBAction func enter() {
        
        userIsInTheMiddleOfTypingANumber = false
        
        guard let operand = displayValue else {
            return
        }
        if let result = brain.pushOperand(operand) {
            displayValue = result
        }
        else {
            displayValue = nil
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
            performOperation(operation)
        }
    }
    
    @IBAction func backspace() {
        
        guard userIsInTheMiddleOfTypingANumber else {
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
    
    @IBAction func addSign(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            let displayText = display.text!
            if displayText.rangeOfString(minus) != nil {
                display.text = displayText.substringFromIndex(displayText.startIndex.successor())
            }
            else {
                display.text = minus + displayText
            }
        }
        else {
            if let operation = sender.currentTitle {
                performOperation(operation)
            }
        }
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
    
    private func performOperation(operation: String) {
        if let result = brain.performOperation(operation) {
            displayValue = result
            history.text = history.text! + "="
        }
        else {
            displayValue = nil
            history.text = history.text! + "ERROR"
        }
    }
    
    var displayValue: Double? {
        get{
            guard let displayText = display.text else {
                return nil
            }
            
            let formatter = NSNumberFormatter()
            formatter.locale = NSLocale(localeIdentifier: "en_US")
            return formatter.numberFromString(displayText)?.doubleValue
        }
        set {
            if let operand = newValue {
                display.text = "\(operand)"
            }
            else {
                display.text = " "
            }
            
            history.text = brain.displayStack
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

