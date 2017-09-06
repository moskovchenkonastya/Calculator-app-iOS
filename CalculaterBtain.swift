//
//  CalculaterBtain.swift
//  calculater_new
//
//  Created by Anastasiya Moskovchenko on 02.12.16.
//  Copyright © 2016 Anastasiya Moskovchenko. All rights reserved.
//

import Foundation

class CalculaterBrain
{
    
    private var accumulator = 0.0
    
    func setOperand(operand: Double) {
        
        accumulator = operand
    }
    
    private var operations: Dictionary<String,Operation> = [
        
        "∏" :Operation.Constant(M_PI), //M_PI,
        "e" : Operation.Constant(M_E), //M_E,
        //"±" : Operation.UnaryOperation({ -$0 }),
        "√" : Operation.UnaryOperation(sqrt), //sqrt,
        "cos" : Operation.UnaryOperation(cos),
        "×" : Operation.BinaryOperation({$0 * $1}),
        "÷" : Operation.BinaryOperation({$0 / $1}),
        "−" : Operation.BinaryOperation({$0 - $1}),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "=" : Operation.Equals
    ]
    
    enum Operation {
        
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double, Double)->Double)
        case Equals
        
    }
    
    func performOperation(symbol: String) {
        
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinaryOperation(let function): pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                if pending != nil{
                    accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
                    pending = nil
                }
            }
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
    
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get{
            return accumulator
        }
    }
}
