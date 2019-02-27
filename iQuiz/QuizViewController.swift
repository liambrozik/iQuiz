//
//  QuizViewController.swift
//  iQuiz
//
//  Created by Liam Brozik on 2/16/19.
//  Copyright © 2019 iSchool. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    var currentQuestion : Int = 0
    var correctAns : Int = 0
    var totalQ : Int = 0
    var quiz : QuizJSON?
    @IBOutlet weak var ans1: UIButton!
    @IBOutlet weak var ans2: UIButton!
    @IBOutlet weak var ans3: UIButton!
    @IBOutlet weak var ans4: UIButton!
    @IBOutlet weak var questionTitle: UILabel!
    var message = ""
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is AnswerViewController
        {
            let vc = segue.destination as? AnswerViewController
            vc?.correct = correctAns
            vc?.total = totalQ
            vc?.currentQuestion = currentQuestion
            vc?.quiz = quiz
            vc?.message = message
        }
    }
    
    @IBAction func answerSelect(_ sender: UIButton) {
        let answer = Int(Array(quiz!.questions!)[currentQuestion].answer)! - 1
        let answerText = Array(quiz!.questions!)[currentQuestion].answers[answer]
        totalQ += 1
        if (sender.tag != answer + 1) {
            message = "Incorrect. The answer is \(answerText)"
        } else {
            message = "Correct!"
            correctAns += 1
        }
        self.performSegue(withIdentifier: "answerSegue", sender: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let questions = quiz!.questions
        questionTitle.text = questions![currentQuestion].text
        print(questions![currentQuestion])
        ans1.setTitle(questions![currentQuestion].answers[0], for: .normal)
        ans2.setTitle(questions![currentQuestion].answers[1], for: .normal)
        ans3.setTitle(questions![currentQuestion].answers[2], for: .normal)
        ans4.setTitle(questions![currentQuestion].answers[3], for: .normal)
        
        // Do any additional setup after loading the view.s
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
