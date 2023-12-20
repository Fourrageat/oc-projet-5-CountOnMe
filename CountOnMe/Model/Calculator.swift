//
//  Calculator.swift
//  CountOnMe
//
//  Created by Baptiste FOURRAGEAT on 20/12/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import Foundation

final class Calculator {
    func calculateResult(from elements: [String]) -> String? {
        var operationsToReduce = elements

        let operatorsPrecedence = ["x", "/"]

        for operatorPrecedence in operatorsPrecedence {
            var index = 0
            while index < operationsToReduce.count {
                if operationsToReduce[index] == operatorPrecedence {
                    if let left = Int(operationsToReduce[index - 1]),
                       let right = Int(operationsToReduce[index + 1]) {
                        let result = performCalculation(left: left, operand: operationsToReduce[index], right: right)

                        operationsToReduce[index - 1] = "\(result)"
                        operationsToReduce.remove(at: index)
                        operationsToReduce.remove(at: index)

                        // Reset the index to check for other operators
                        index = 0
                    }
                }

                index += 1
            }
        }

        return operationsToReduce.first
    }

    private func performCalculation(left: Int, operand: String, right: Int) -> Int {
        switch operand {
        case "+": return left + right
        case "-": return left - right
        case "x": return left * right
        case "/": return left / right
        default: fatalError("Unknown operator !")
        }
    }
}
