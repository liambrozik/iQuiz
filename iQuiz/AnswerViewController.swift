//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Liam Brozik on 2/26/19.
//  Copyright © 2019 iSchool. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    var message = ""
    var correct = 0
    var total = 0
    var currentQuestion = 0
    var quiz : QuizJSON?
    @IBOutlet weak var reveal: UILabel!
    
    @IBAction func nextPress(_ sender: UIButton) {
        if (currentQuestion < Array(quiz!.questions!).count - 1) {
            currentQuestion += 1
            self.performSegue(withIdentifier: "quizSegue", sender: self)
        } else {
            self.performSegue(withIdentifier: "finishSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "finishSegue"
        {
            let vc = segue.destination as? FinishViewController
            vc?.correct = correct
            vc?.total = total
        }
        else if segue.identifier == "quizSegue"
        {
            let vc = segue.destination as? QuizViewController
            vc?.quiz = quiz!
            vc?.currentQuestion = currentQuestion
            vc?.totalQ = total
            vc?.correctAns = correct
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        reveal.text = message
        // Do any additional setup after loading the view.
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
