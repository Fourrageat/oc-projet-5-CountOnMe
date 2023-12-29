//
//  CalculatorTestCase.swift
//  CountOnMeTests
//
//  Created by Baptiste FOURRAGEAT on 21/12/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

final class CalculatorTestCase: XCTestCase {

    private func assertion(givenExpression: [String], expected: String) {
        let calculator = Calculator()

        let received = calculator.calculateResult(from: givenExpression)

        XCTAssertEqual(received, expected)
    }

    func testAddition() {
        assertion(givenExpression: ["5", "+", "1"], expected: "6")
    }

    func testSoustraction() {
        assertion(givenExpression: ["5", "-", "1"], expected: "4")
    }

    func testMultiplication() {
        assertion(givenExpression: ["5", "x", "2"], expected: "10")
    }

    func testDivision() {
        assertion(givenExpression: ["10", "/", "2"], expected: "5")
    }

    func testOperatorPriority() {
        assertion(givenExpression: ["3", "x", "2", "+", "6", "/", "3"], expected: "8")
    }

    func testUnknownOperator() {
        assertion(givenExpression: ["3", "$", "2"], expected: "Error")
    }

    func testDivisionByZero() {
        assertion(givenExpression: ["4", "/", "0"], expected: "Error")
    }
}
