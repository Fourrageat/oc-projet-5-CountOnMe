//
//  Calculator.swift
//  CountOnMe
//
//  Created by Baptiste FOURRAGEAT on 20/12/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import Foundation

final class Calculator {

    private let operatorsOrderPriority = [["x", "/"], ["+", "-"]]

    private enum CalculationError: Error {
        case invalidOperator
    }

    func calculateResult(from elements: [String]) -> String? {
        var operationsToReduce = elements

        for operators in operatorsOrderPriority {
            handleOperations(of: operators, in: &operationsToReduce)
        }

        if operationsToReduce.contains("Error") {
            return "Error"
        }

        return operationsToReduce.first
    }

    private func handleOperations(of operators: [String], in operations: inout [String]) {
        var index = 0
        while index < operations.count {
            if operators.contains(operations[index]) {
                if let left = Int(operations[index - 1]),
                   let right = Int(operations[index + 1]) {
                    let result = performCalculation(left: left, usedOperator: operations[index], right: right)

                    operations[index - 1] = result

                    for _ in 1...2 {
                        operations.remove(at: index)
                    }

                    // Reset the index to check for other operators
                    index = 0
                }
            }

            index += 1
        }
    }

    private func performCalculation(left: Int, usedOperator: String, right: Int) -> String {
        switch usedOperator {
        case "+": return "\(left + right)"
        case "-": return "\(left - right)"
        case "x": return "\(left * right)"
        case "/":
            guard right != 0 else {
                return "Error"
            }
            return "\(left / right)"
        default:
            return "Error"
        }
    }
}
