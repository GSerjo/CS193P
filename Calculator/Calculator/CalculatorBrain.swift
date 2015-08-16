//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Serjo on 15/08/15.
//  Copyright © 2015 Serjo. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private var opStack = [Op]()
    private var knownOps = [String: Op]()
    
    private enum Op: CustomStringConvertible {
        
        case Constant(String, () -> Double)
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                case .Constant(let symbol, _):
                    return symbol
                }
            }
        }
    }
    
    init() {
        
        func learnOp(op: Op) {
            knownOps[op.description] = op
        }
        
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("−") { $1 - $0 })
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("÷") { $1 / $0 })
        learnOp(Op.UnaryOperation("√", sqrt))
        learnOp(Op.UnaryOperation("sin", sin))
        learnOp(Op.UnaryOperation("cos", cos))
        learnOp(Op.Constant("π") { M_PI })
    }
    
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
    
    private func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        print("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        
        if ops.isEmpty {
            return (nil, ops)
        }
        
        var remainigOps = ops
        let op = remainigOps.removeLast()
        
        switch op {
        case .Operand(let operand):
            return (operand, remainigOps)
        case .Constant(_, let operation):
            return (operation(), remainigOps)
        case .UnaryOperation(_, let operation):
            let evaluation = evaluate(remainigOps)
            if let operand = evaluation.result {
                return (operation(operand), remainigOps)
            }
        case .BinaryOperation(_, let operation):
            let evaluation1 = evaluate(remainigOps)
            if let operand1 = evaluation1.result {
                let evaluation2 = evaluate(evaluation1.remainingOps)
                if let operand2 = evaluation2.result {
                    return (operation(operand1, operand2), evaluation2.remainingOps)
                }
            }
        }
        return (nil, ops)
    }
}
