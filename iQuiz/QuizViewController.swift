//
//  QuizViewController.swift
//  iQuiz
//
//  Created by Liam Brozik on 2/16/19.
//  Copyright © 2019 iSchool. All rights reserved.
//

import UIKit
class QuizViewController: UIViewController {

    var question1: String = ""
    var question2: String = ""
    var question3: String = ""
    var question4: String = ""
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label1?.text = question1
        label2?.text = question2
        label3?.text = question3
        label4?.text = question4
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
