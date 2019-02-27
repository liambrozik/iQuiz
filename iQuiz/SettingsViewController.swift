//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by Liam Brozik on 2/26/19.
//  Copyright © 2019 iSchool. All rights reserved.
//

import UIKit

protocol PopoverDelegate {
    func popoverDismissed()
}

class SettingsViewController: UIViewController {
    var delegate: PopoverDelegate!
    var quizzes: [QuizJSON]?
    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var warning: UILabel!
    @IBOutlet weak var checkNow: UIButton!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var directions: UILabel!
    @IBOutlet weak var downloading: UILabel!
    
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.delegate?.popoverDismissed()
        })
        
    }
    @IBAction func checkPress(_ sender: Any) {
        checkNow.isHidden = true
        downloading.isHidden = false
        warning.isHidden = true
        successLabel.isHidden = true
        directions.isHidden = true
        let urlString = urlField.text
        if (urlString == "" || urlString == nil) {
            warning.isHidden = false
            checkNow.isHidden = false
            downloading.isHidden = true
        } else {
            guard let url = URL(string: urlString!) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    DispatchQueue.main.async {
                        //print(articlesData)
                        self.warning.isHidden = false
                        self.checkNow.isHidden = false
                        self.downloading.isHidden = true
                        print(error!.localizedDescription)
                    }
                }
                
                guard let data = data else { return }
                //Implement JSON decoding and parsing
                do {
                    //Decode retrived data with JSONDecoder and assing type of Article object
                    let fileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        .appendingPathComponent("quizzes.json") // Your json file name
                    try? data.write(to: fileUrl)
                    //Get back to the main queue
                    DispatchQueue.main.async {
                        //print(articlesData)
                        self.warning.isHidden = true
                        self.checkNow.isHidden = false
                        self.downloading.isHidden = true
                        self.successLabel.isHidden = false
                        self.directions.isHidden = false
                    }
                    
                }
                
                }.resume()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
