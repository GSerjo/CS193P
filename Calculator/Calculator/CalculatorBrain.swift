//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Serjo on 24/07/16.
//  Copyright © 2016 Serjo. All rights reserved.
//

import Foundation

final class CalculatorBrain {
    
    private var accumulator = 0.0
    private var pending: PendingBinaryOperationInfo?
    
    private let operations: Dictionary<String, Operation> = [
        "∏" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "-" : Operation.BinaryOperation({$0 - $1}),
        "×" : Operation.BinaryOperation({$0 * $1}),
        "÷" : Operation.BinaryOperation({$0 / $1}),
        "=" : Operation.Equals
    ]
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation(Double -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    func perforOperation(symbol: String) {
        guard let operation = operations[symbol] else {
            return
        }
        
        switch operation {
        case .Constant(let value): accumulator = value
        case .UnaryOperation(let function): accumulator = function(accumulator)
        case .BinaryOperation(let function):
            executePendingBinaryOperation()
            pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
        case .Equals: executePendingBinaryOperation()
        }
    }
    
    func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.function(secondOperand: accumulator)
            pending = nil
        }
    }
    
    private struct PendingBinaryOperationInfo {
        init(binaryFunction: (Double, Double) -> Double, firstOperand: Double){
            function = { binaryFunction(firstOperand, $0) }
        }
        let function: (secondOperand: Double) -> Double
    }
}
