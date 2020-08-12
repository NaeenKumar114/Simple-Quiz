//
//  QuizBrain.swift
//  Quiz
//
//  Created by Naveen Natrajan on 2020-08-08.
//  Copyright © 2020 Naveen Natrajan. All rights reserved.
//

import Foundation
protocol quizEndProtocol {
    func didEnd(score : Int , timeTaken : Double)
}
struct QuizBrain {
    var delegate : quizEndProtocol!
    var questionNumber = 0
    var score = 0
    var timeTaken = 0
    var startingTime : String!
    var t : Double!
    var quizQuestionAndAnswers : [quizQuestions]!
   
    mutating func getQuestions()
    {
        let urlString = "https://opentdb.com/api.php?amount=10&difficulty=easy&type=multiple"
        
        if  let url = URL(string: urlString)
        {
            if let data = try? Data(contentsOf: url)
            {
                parse(json: data)
            }
        }
    }
    mutating func updateTimer() -> Int
    {
        timeTaken += 1
        return timeTaken
    }
    mutating func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonQuestions = try? decoder.decode(QuizData.self, from: json) {
            for i in 0 ... 9{
                quizQuestionAndAnswers = jsonQuestions.results
                // print(jsonQuestions.results[i].question.htmlAttributedString!.string)
                print(quizQuestionAndAnswers[i].correct_answer)
                print(quizQuestionAndAnswers[i].question.htmlAttributedString!.string)
                print("")
                
            }
        }
    }
    
    mutating func getQuestionText() -> String {
        if questionNumber == 0
        {
            
            t = Date.timeIntervalSinceReferenceDate
        }
      
        // return quiz[questionNumber].text
        return quizQuestionAndAnswers[questionNumber].question.htmlAttributedString!.string
    }
    
    func getAnswers() -> [String] {
        // return quiz[questionNumber].answers
        var answers = quizQuestionAndAnswers[questionNumber].incorrect_answers
        answers.append(quizQuestionAndAnswers[questionNumber].correct_answer)
        answers.shuffle()
        return answers
        
    }
    
    func getProgress() -> Float {
        return Float(questionNumber) / Float(quizQuestionAndAnswers.count)
    }
    
     func getScore() -> Int {
        return score
    }
    
    mutating func nextQuestion() {
        
        if questionNumber + 1 < quizQuestionAndAnswers.count {
            questionNumber += 1
        } else {
            delegate.didEnd(score: score, timeTaken: Date.timeIntervalSinceReferenceDate - t)
            score = 0
            questionNumber = 0
        }
    }
    func getCorrectAnswer() -> String{
        //return quiz[questionNumber].rightAnswer
        return quizQuestionAndAnswers[questionNumber].correct_answer.htmlAttributedString!.string
    }
    mutating func checkAnswer(userAnswer: String) -> Bool {
        //Need to change answer to rightAnswer here.
        if userAnswer == quizQuestionAndAnswers[questionNumber].correct_answer.htmlAttributedString!.string {
            score += 1
            return true
        } else {
            return false
        }
    }
}

extension String {
    /// Converts HTML string to a `NSAttributedString`
    
    var htmlAttributedString: NSAttributedString? {
        return try? NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
}
