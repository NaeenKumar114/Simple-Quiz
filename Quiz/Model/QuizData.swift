//
//  QuizData.swift
//  Quiz
//
//  Created by Naveen Natrajan on 2020-08-10.
//  Copyright © 2020 Naveen Natrajan. All rights reserved.
//

import Foundation

struct QuizData : Decodable {
    let results : [quizQuestions]
}

struct quizQuestions : Decodable {
    let question : String
    let correct_answer : String
    let incorrect_answers : [String]
    
}
