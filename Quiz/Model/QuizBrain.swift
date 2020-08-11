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
    let quiz = [
        Question(q: "Which is the largest organ in the human body?", a: ["Heart", "Skin", "Large Intestine"], correctAnswer: "Skin"),
        Question(q: "Five dollars is worth how many nickels?", a: ["25", "50", "100"], correctAnswer: "100"),
        Question(q: "What do the letters in the GMT time zone stand for?", a: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"], correctAnswer: "Greenwich Mean Time"),
        Question(q: "What is the French word for 'hat'?", a: ["Chapeau", "Écharpe", "Bonnet"], correctAnswer: "Chapeau"),
        Question(q: "In past times, what would a gentleman keep in his fob pocket?", a: ["Notebook", "Handkerchief", "Watch"], correctAnswer: "Watch"),
        Question(q: "How would one say goodbye in Spanish?", a: ["Au Revoir", "Adiós", "Salir"], correctAnswer: "Adiós"),
        Question(q: "Which of these colours is NOT featured in the logo for Google?", a: ["Green", "Orange", "Blue"], correctAnswer: "Orange"),
        Question(q: "What alcoholic drink is made from molasses?", a: ["Rum", "Whisky", "Gin"], correctAnswer: "Rum"),
        Question(q: "What type of animal was Harambe?", a: ["Panda", "Gorilla", "Crocodile"], correctAnswer: "Gorilla"),
        Question(q: "Where is Tasmania located?", a: ["Indonesia", "Australia", "Scotland"], correctAnswer: "Australia")
    ]
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
        return Float(questionNumber) / Float(quiz.count)
    }
    
    mutating func getScore() -> Int {
        return score
    }
    
    mutating func nextQuestion() {
        
        if questionNumber + 1 < quiz.count {
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
