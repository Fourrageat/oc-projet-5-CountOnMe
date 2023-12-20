//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }

    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }

    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }

    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }

    var calculator = Calculator()

    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }

        if expressionHaveResult {
            textView.text = ""
        }

        textView.text.append(numberText)
    }

    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" + ")
        } else {
            showAlert(title: "Zéro!", message: "Un operateur est déja mis !")
        }
    }

    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" - ")
        } else {
            showAlert(title: "Zéro!", message: "Un operateur est déja mis !")
        }
    }

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
}

private extension ViewController {
    private func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
