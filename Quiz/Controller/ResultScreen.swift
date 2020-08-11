//
//  ResultScreen.swift
//  Quiz
//
//  Created by Naveen Natrajan on 2020-08-11.
//  Copyright © 2020 Naveen Natrajan. All rights reserved.
//

import UIKit

class ResultScreen: UIViewController {

  
    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var resultLable: UILabel!
    @IBOutlet weak var timeTakenLable: UILabel!
    var finalScore : Int!
    var totalTimeTaken : Double!
    
    @IBAction func reDoPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "reDO", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLable.text = String(finalScore)
        timeTakenLable.text = String(Int(totalTimeTaken))
        if finalScore > 4 {
            resultLable.text = "Pass"
            resultLable.textColor = UIColor.green
        } else {
            resultLable.text = "Fail"
            resultLable.textColor = UIColor.red
        }
        // Do any additional setup after loading the view.
    }
    

    

}
