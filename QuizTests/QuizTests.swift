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
    var quizBrain = QuizBrain()
    
    func testGetQuestions()
    {
        quizBrain.getQuestions()
        XCTAssertNotNil(quizBrain.quizQuestionAndAnswers)
    }
    func testGetScore()
    {
        quizBrain.getQuestions()
        XCTAssertNotNil(quizBrain.getScore)
    }
}
