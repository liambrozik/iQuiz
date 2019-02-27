//
//  FinishViewController.swift
//  iQuiz
//
//  Created by Liam Brozik on 2/25/19.
//  Copyright © 2019 iSchool. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {

    var correct : Int = 0
    var total : Int = 4
    
    @IBAction func backToQuiz(_ sender: Any) {
        self.navigationController?.popToRootViewController( animated: true )
    }
    @IBOutlet weak var feedback: UILabel!
    @IBOutlet weak var score: UILabel!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        score.text = "\(correct) \\ \(total)"
        let userScore = Float(correct) / Float(total)
        if correct / total == 1 {
            feedback.text = "Perfect!"
        } else if userScore >= 0.75 {
            feedback.text = "Great job!"
        } else if userScore >= 0.50 {
            feedback.text = "Nice job!"
        } else if userScore >= 0.25 {
            feedback.text = "You'll get it!"
        } else {
            feedback.text = "Maybe this subject isn't for you..."
        }
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
