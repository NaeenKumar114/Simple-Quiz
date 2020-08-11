//
//  ViewController.swift
//  Quiz
//
//  Created by Naveen Natrajan on 2020-08-07.
//  Copyright © 2020 Naveen Natrajan. All rights reserved.
//

import UIKit
class ViewController: UIViewController, quizEndProtocol {
   
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    //Added another button and a corroponding outlet.
    @IBOutlet weak var choice1: UIButton!
    @IBOutlet weak var choice2: UIButton!
    @IBOutlet weak var choice3: UIButton!
    @IBOutlet weak var choice4: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    var quizBrain = QuizBrain()
    var timerTakenTimer :Timer!
    var finalScore : Int!
    var totalTimeTaken : Double!
    override func viewDidLoad() {
        super.viewDidLoad()
        quizBrain.delegate = self
        quizBrain.getQuestions()
        updateUI()
        //timerTakenTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer ()
    {
        scoreLabel.text = String(quizBrain.updateTimer())
    }
    func didEnd(score: Int, timeTaken: Double) {
       // timerTakenTimer.invalidate()
        finalScore = score
        totalTimeTaken = timeTaken
        print(score , timeTaken)
       performSegue(withIdentifier: "toFinalSegue", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFinalSegue" {
            if let destinationVC = segue.destination as? ResultScreen{
                destinationVC.finalScore = finalScore
                destinationVC.totalTimeTaken = totalTimeTaken
            }
        }
    }
    //New button needs to be linked to this IBAction too.
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle!
        
        let userGotItRight = quizBrain.checkAnswer(userAnswer: userAnswer)
        
        if userGotItRight {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
            print(userAnswer)
            showCorrectAnswer()
        }
        
        quizBrain.nextQuestion()
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        
    }
    
    @objc func updateUI() {
        questionLabel.text = quizBrain.getQuestionText()
        
        //Need to fetch the answers and update the button titles using the setTitle method.
        let answerChoices = quizBrain.getAnswers()
        choice1.setTitle(answerChoices[0].htmlAttributedString!.string, for: .normal)
        choice2.setTitle(answerChoices[1].htmlAttributedString!.string, for: .normal)
        choice3.setTitle(answerChoices[2].htmlAttributedString!.string, for: .normal)
        choice4.setTitle(answerChoices[3].htmlAttributedString!.string, for: .normal)
        progressBar.progress = quizBrain.getProgress()
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        
        choice1.backgroundColor = UIColor.clear
        choice2.backgroundColor = UIColor.clear
        choice3.backgroundColor = UIColor.clear
        choice4.backgroundColor = UIColor.clear
        
    }
    func showCorrectAnswer()
    {
        let correctAnswer =  quizBrain.getCorrectAnswer()
        print(correctAnswer)
        switch correctAnswer {
        case choice1.currentTitle:
            choice1.backgroundColor = UIColor.green
            
        case choice2.currentTitle:
            choice2.backgroundColor = UIColor.green
            
        case choice3.currentTitle:
            choice3.backgroundColor = UIColor.green
            
        case choice4.currentTitle:
            choice4.backgroundColor = UIColor.green
            
        default:
            print("err")
            break
        }
    }
}
