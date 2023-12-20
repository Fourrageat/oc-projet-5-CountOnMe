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

        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!

            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }

            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }

        return operationsToReduce.first
    }
}
