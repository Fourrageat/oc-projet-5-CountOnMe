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

    var calculator = Calculator()

    func testAddition() {
        // Given
        let inputExpression = ["5", "+", "1"]
        let expectedSum = "6"

        // When
        guard let result = calculator.calculateResult(from: inputExpression) else {
            XCTFail("Result is nil")
            return
        }

        XCTAssertEqual(result, expectedSum, "Addition result is incorrect")
    }
}
