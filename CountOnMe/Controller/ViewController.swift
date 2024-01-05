//
//  ViewController.swift
//  CountOneMe
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

/**
 # CountOneMe - ViewController Documentation

 ## Overview

 The `ViewController` is a Swift class responsible for managing the user interface and handling user interactions
 for the CountOneMe calculator app. It utilizes the Model-View-Controller (MVC) architecture to separate concerns and
 maintain a clean code structure.

 ## Class Structure

 - **Class Name:** `ViewController`
 - **Inherits from:** `UIViewController`

 ## Properties

 ### Outlets

 - `textView: UITextView`: Displays and handles the user input and calculation results.
 - `numberButtons: [UIButton]`: Collection of buttons representing numerical digits.

 ### Computed Variables

 - `elements: [String]`: Splits the content of the `textView` into an array of strings, facilitating
 expression analysis.

 #### Error Check Computed Variables

 - `expressionIsCorrect: Bool`: Checks if the current expression is valid.
 - `expressionHaveEnoughElement: Bool`: Checks if the expression has enough elements for calculation.
 - `canAddOperator: Bool`: Determines if an operator can be added to the expression.
 - `expressionHaveResult: Bool`: Checks if the expression contains a result.

 ### Private Constants

 - `calculator: Calculator`: An instance of the `Calculator` class for performing calculations.

 ## View Actions

 ### Number Button Action

 - `tappedNumberButton(_ sender: UIButton)`: Appends the tapped number to the `textView`.

 ### Operator Button Action

 - `tappedOperatorButton(_ sender: UIButton)`: Adds the tapped operator to the `textView`
 using the `addToTextView` method.

 ### Equal Button Action

 - `tappedEqualButton(_ sender: UIButton)`: Initiates the calculation process, displaying the
 result or showing an error alert based on expression validity.

 ## Private Methods

 - `showAlert(title: String, message: String)`: Displays an alert with the specified title and message.
 - `showAlertOperators()`: Shows an alert indicating that an operator is already present.
 - `addToTextView(currentOperator: String)`: Appends the given operator to the `textView`
 if allowed; otherwise, displays an alert.

 ## Implementation Notes

 - The controller uses the `Calculator` class for actual calculations.
 - Alerts are displayed to communicate errors or invalid expressions to the user.

 ---

 # CountOneMe - Calculator Documentation

 ## Overview

 The `Calculator` class is responsible for performing arithmetic calculations based on user input in the
 CountOneMe calculator app.

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

 - The class follows a simple order of operations: multiplication and division first, followed by addition
 and subtraction.
 - Calculation errors are handled and returned as a string "Error."

 */
final class ViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    // MARK: - Computed Variables

    /// Splits the content of the `textView` into an array of strings, facilitating expression analysis.
    private var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }

    // MARK: - Error Check Computed Variables

    /// Checks if the current expression is valid.
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }

    /// Checks if the expression has enough elements for calculation.
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    /// Determines if an operator can be added to the expression.
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }

    /// Checks if the expression contains a result.
    private var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }

    // MARK: - Private Properties

    /// An instance of the `Calculator` class for performing calculations.
    private let calculator = Calculator()

    // MARK: - View Actions

    /// Handles the tap on number buttons, appending the pressed number to the `textView`.
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if expressionHaveResult {
            textView.text = ""
        }
        textView.text.append(numberText)
    }

    /// Handles the tap on operator buttons, adding the pressed operator to the `textView`.
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let operatorText = sender.title(for: .normal) else {
            return
        }

        addToTextView(currentOperator: " \(operatorText) ")
    }

    /// Handles the tap on the equal button, initiating the calculation process and displaying the result
    /// or an error alert.
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else {
            // Handle incorrect expression
            showAlert(title: "Zéro!", message: "Entrez une expression correcte !")
            return
        }

        guard expressionHaveEnoughElement else {
            // Handle not enough elements
            showAlert(title: "Zéro!", message: "Démarrez un nouveau calcul !")
            return
        }

        if let result = calculator.calculateResult(from: elements) {
            textView.text.append(" = \(result)")
        } else {
            // Handle calculation error
            showAlert(title: "Erreur de calcul", message: "Une erreur est survenue lors du calcul.")
        }
    }

    /// Handles the tap on the reset button, deleting current string on the screen
    @IBAction func tappedResetButton(_ sender: UIButton) {
        clearScreen()
    }

    /// Called affter the device, screen loaded
    override func viewDidLoad() {
        clearScreen()
        textView.isScrollEnabled = true
    }
}

// MARK: - Private Extension

private extension ViewController {

    /// Replace screen string by an empty string
    private func clearScreen() {
        textView.text = ""
    }

    /// Displays an alert with the specified title and message.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message to be displayed in the alert.
    private func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }

    /// Shows an alert indicating that an operator is already present.
    private func showAlertOperators() {
        showAlert(title: "Zéro!", message: "Un operateur est déja mis !")
    }

    /// Appends the given operator to the `textView` if allowed; otherwise, displays an alert.
    ///
    /// - Parameter currentOperator: The operator to be added to the `textView`.
    private func addToTextView(currentOperator: String) {
        if canAddOperator {
            textView.text.append(currentOperator)
        } else {
            showAlertOperators()
        }
    }
}
