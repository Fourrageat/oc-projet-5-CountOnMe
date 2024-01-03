//
//  Calculator.swift
//  CountOnMe
//
//  Created by Baptiste FOURRAGEAT on 20/12/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import Foundation

/**
 # CountOneMe - Calculator Documentation

 ## Overview

 The `Calculator` class is a Swift model responsible for performing arithmetic calculations based on user input in the CountOneMe calculator app.

 ## Class Structure

 - **Class Name:** `Calculator`
 - **Inherits from:** `NSObject`

 ## Properties

 - `operatorsOrderPriority: [[String]]`: Defines the order of operator priority for calculations.

 ## Methods

 ### `calculateResult(from elements: [String]) -> String?`

 Calculates the result of the given expression.

 - **Parameters:**
   - `elements: [String]`: An array of string elements representing the mathematical expression.
 - **Returns:**
   - `String?`: The result of the calculation or `nil` if an error occurs.

 ### Private Methods

 #### `handleOperations(of operators: [String], in operations: inout [String])`

 Handles operations based on the given priority and modifies the array of operations in place.

 #### `performCalculation(left: Int, usedOperator: String, right: Int) -> String`

 Performs the arithmetic calculation based on the left operand, operator, and right operand.

 - **Parameters:**
   - `left: Int`: The left operand.
   - `usedOperator: String`: The operator to be applied.
   - `right: Int`: The right operand.
 - **Returns:**
   - `String`: The result of the calculation or an error message.

 ## Implementation Notes

 - The class follows a simple order of operations: multiplication and division first, followed by addition and subtraction.
 - Calculation errors are handled and returned as a string "Error."

 ---

 *Note: This documentation provides an overview of the class structure, properties, methods, and their functionalities. Additional details or specifics may be required based on the future evolution of the code.*
CountOn
 */
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

        if operationsToReduce.contains("Error") || operationsToReduce.count > 1 {
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
