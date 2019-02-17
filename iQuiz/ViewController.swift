//
//  ViewController.swift
//  iQuiz
//
//  Created by Liam Brozik on 2/15/19.
//  Copyright © 2019 iSchool. All rights reserved.
//

import UIKit

class Quiz {
    var title : String
    var desc: String
    var questions: [String: [String]]
    
    init(title: String, description: String, questions: [String: [String]]) {
        self.title = title
        self.desc = description
        self.questions = questions
    }
}

class DataSource : NSObject, UITableViewDataSource
{
    var id : Int = 0
    var data : [Quiz]
    
    init(quizzes: [Quiz]) {
        data = quizzes
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")!
        
        cell.textLabel?.text = data[indexPath.row].title
        cell.detailTextLabel?.text = data[indexPath.row].desc
        
        return cell
    }
}

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    var selected: Int = 0
    var quizzes: [Quiz] = []
    var dataSource : DataSource? = nil
    
    @IBAction func settingsPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings", message: "Go Here", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("User selected row at \(indexPath)")
        selected = indexPath.row
        self.performSegue(withIdentifier: "yourSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is QuizViewController
        {
            let vc = segue.destination as? QuizViewController
            let quiz: Quiz = quizzes[selected]
            let questions = quiz.questions
            vc?.question1 = Array(questions)[0].key
            vc?.question2 = Array(questions)[1].key
            vc?.question3 = Array(questions)[2].key
            vc?.title = quiz.title
        }
    }
    
    func makeQuizzes() -> [Quiz] {
        let q1: Quiz = Quiz(title: "Mathematics", description: "Arithmetic and algebraic operations", questions: ["What is 2+2?": ["1", "4", "Fish", "x", "Sandwich"], "y = 5x - 1, for y = 3, what is x?": ["2", "7", "10", "25", "3"], "83 modulo 9": ["3", "0", "1", "2", "4"]])
        let q2: Quiz = Quiz(title: "Marvel Super Heroes", description: "Marvel comics super heroes", questions: ["Which hero is from norse mythology?": ["2", "Captain America", "Thor", "Ironman", "Spiderman"], "Which hero is not licensed for film by Disney?": ["4", "Captain America", "Thor", "Ironman", "Spiderman"], "Which of these heroes is not a Marvel superhero?": ["3", "Black Widow", "Hawkeye", "Captain Marvel", "Wolverine"]])
        let q3: Quiz = Quiz(title: "Science", description: "The broad topic of Science", questions: ["Which of the following is pseudoscience?": ["2", "Ornithology", "Astrology", "Nutrition", "Pharmacology"], "Which branch of science studies cancer?": ["3", "Podiatry", "Canerology", "Oncology", "Bionetics"], "Which branch of science studies fossils?": ["4", "Archaeology", "Architecture", "Dianetics", "Paleontology"]])
        return [q1, q2, q3]
    }
    
    @objc func refresh(_ sender: Any) {
        refreshControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.tintColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        quizzes = makeQuizzes()
        dataSource = DataSource(quizzes: quizzes)
        tableView.dataSource = dataSource
        tableView.rowHeight = 90;
        tableView.delegate = self
        tableView.reloadData()
    }

}

