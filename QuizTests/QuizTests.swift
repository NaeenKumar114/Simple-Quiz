//
//  QuizTests.swift
//  QuizTests
//
//  Created by Naveen Natrajan on 2020-08-07.
//  Copyright © 2020 Naveen Natrajan. All rights reserved.
//

import XCTest
@testable import Quiz

class QuizTests: XCTestCase {
    func testHello()
    {
        var quizBrainTest = QuizBrain()
      let answer = quizBrainTest.checkAnswer(userAnswer: "Skin")
        XCTAssertTrue(answer)
    }
}
