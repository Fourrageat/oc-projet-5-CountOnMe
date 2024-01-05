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

 The `Calculator` class is a Swift model responsible for performing arithmetic calculations based on
 user input in the CountOneMe calculator app.

 ## Class Structure

 - **Class Name:** `Calculator`

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
 
 ### Static Methods

 #### `performCalculation(left: Int, usedOperator: String, right: Int) -> String`

 Performs the arithmetic calculation based on the left operand, operator, and right operand.

 - **Parameters:**
   - `left: Int`: The left operand.
   - `usedOperator: String`: The operator to be applied.
   - `right: Int`: The right operand.
 - **Returns:**
   - `String`: The result of the calculation or an error message.

 ## Implementation Notes

 - The class follows a simple order of operations: multiplication and division first, followed by addition
 and subtraction.
 - Calculation errors are handled and returned as a string "Error."

 */
final class Calculator {

    // MARK: - Properties

    /// Defines the order of operator priority for calculations.
    private let operatorsOrderPriority = [["x", "/"], ["+", "-"]]

    // MARK: - Enums

    /// Represents possible errors that can occur during calculation.
    private enum CalculationError: Error {
        case invalidOperator
    }

    // MARK: - Public Methods

    /// Calculates the result of the given expression.
    ///
    /// - Parameter elements: An array of string elements representing the mathematical expression.
    /// - Returns: The result of the calculation or `nil` if an error occurs.
    func calculateResult(from elements: [String]) -> String? {
        var operationsToReduce = elements

        // Iterate through operator priorities and handle operations accordingly
        for operators in operatorsOrderPriority {
            handleOperations(of: operators, in: &operationsToReduce)
        }

        // Check for errors or multiple results
        if operationsToReduce.contains("Error") || operationsToReduce.count > 1 {
            return "Error"
        }

        return operationsToReduce.first
    }

    // MARK: - Private Methods

    /// Handles operations based on the given priority and modifies the array of operations in place.
    ///
    /// - Parameters:
    ///   - operators: An array of operators defining the current priority.
    ///   - operations: The array of string elements representing the mathematical expression.
    private func handleOperations(of operators: [String], in operations: inout [String]) {
        var index = 0

        // Iterate through the operations array
        while index < operations.count {
            if operators.contains(operations[index]) {
                // Check if left and right operands are valid integers
                if let left = Int(operations[index - 1]),
                   let right = Int(operations[index + 1]) {
                    // Perform the calculation
                    let result = Self.performCalculation(left: left, usedOperator: operations[index], right: right)

                    // Update the result in the operations array
                    operations[index - 1] = result

                    // Remove the used operator and right operand from the array
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

    // MARK: - Static Methods

    /// Performs the arithmetic calculation based on the left operand, operator, and right operand.
    ///
    /// - Parameters:
    ///   - left: The left operand.
    ///   - usedOperator: The operator to be applied.
    ///   - right: The right operand.
    /// - Returns: The result of the calculation or an error message.
    static func performCalculation(left: Int, usedOperator: String, right: Int) -> String {
        switch usedOperator {
        case "+": return "\(left + right)"
        case "-": return "\(left - right)"
        case "x": return "\(left * right)"
        case "/":
            // Check for division by zero
            guard right != 0 else {
                return "Error"
            }
            return "\(left / right)"
        default:
            return "Error"
        }
    }
}
