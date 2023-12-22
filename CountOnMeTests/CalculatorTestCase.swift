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

    var calculator: Calculator!

    override func setUp() {
        super.setUp()

        calculator = Calculator()
    }

    func testAddition() {
        let givenExpression = ["5", "+", "1"]
        let expected = "6"

        let received = calculator.calculateResult(from: givenExpression)

        XCTAssertEqual(received, expected)
    }

    func testSoustraction() {
        let givenExpression = ["5", "-", "1"]
        let expected = "4"

        let received = calculator.calculateResult(from: givenExpression)

        XCTAssertEqual(received, expected)
    }

    func testMultiplication() {
        let givenExpression = ["5", "x", "2"]
        let expected = "10"

        let received = calculator.calculateResult(from: givenExpression)

        XCTAssertEqual(received, expected)
    }

    func testDivision() {
        let givenExpression = ["10", "/", "2"]
        let expected = "5"

        let received = calculator.calculateResult(from: givenExpression)

        XCTAssertEqual(received, expected)
    }

    func testOperatorPriority() {
        let givenExpression = ["3", "x", "2", "+", "6", "/", "3"]
        let expected = "8"

        let received = calculator.calculateResult(from: givenExpression)

        XCTAssertEqual(received, expected)
    }
}
