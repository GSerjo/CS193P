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
    private var operandStack = [Double]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        print(operandStack)
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        let operation = sender.currentTitle!
        switch operation{
        case "÷": performOperation{ $0 / $1 }
        case "×": performOperation{ $0 * $1 }
        case "+": performOperation{ $0 + $1 }
        case "−": performOperation{ $0 - $1 }
        case "√": performOperation{ sqrt($01) }
        default:
            break
        }
        
    }
    
    private func performOperation(operation: Double -> Double){
        if operandStack.count < 1{
            return
        }
        
        displayValue = operation(operandStack.removeLast())
        enter()
    }
    
    private func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count < 2{
            return
        }
        
        displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
        enter()
    }
    
    var displayValue: Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

