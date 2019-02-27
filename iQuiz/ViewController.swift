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
    var data : [QuizJSON]
    
    init(quizzes: [QuizJSON]) {
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

class ViewController: UIViewController, UITableViewDelegate, UIPopoverPresentationControllerDelegate, PopoverDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    var selected: Int = 0
    var quizzes: [QuizJSON] = []
    var dataSource : DataSource? = nil
    
    @IBAction func settingsPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings", message: "Go Here", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        
        print("Popover dismisssed")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("User selected row at \(indexPath)")
        selected = indexPath.row
        self.performSegue(withIdentifier: "yourSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        var currentQuiz : QuizJSON
        if segue.identifier == "yourSegue"
        {
            let vc = segue.destination as? QuizViewController
            currentQuiz = quizzes[selected]
            print("QUIZ TO QUIZ: \(currentQuiz)")
            vc?.quiz = currentQuiz
        } else if segue.identifier == "settingsSegue" {
            print("segue to settings")
            let vc = segue.destination as? SettingsViewController
            vc?.delegate = self
        }
    }
    
    func generateQuizzes(quizzs: [QuizJSON]) {
        print("we made it..")
        print(quizzs)
        print(quizzs[0].title)
        quizzes = quizzs
        dataSource = DataSource(quizzes: quizzes)
        tableView.dataSource = dataSource
        tableView.rowHeight = 90;
        tableView.delegate = self
        tableView.reloadData()
        print("YTAY")
    }
    func loadFromLocal() {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("quizzes.json")
        do {
            let data = try? Data(contentsOf: fileURL)
            do
            {
                if (data == nil) {
                    print("local retrieve failed")
                } else {
                    let articlesData = try? JSONDecoder().decode([QuizJSON].self, from: data!)
                    if (articlesData == nil) {
                        print("decode failed")
                    } else {
                        generateQuizzes(quizzs: articlesData!)
                    }
                }
            }
        }
    }
    func popoverDismissed() {
        print("POPOVER DISMISSED")
        loadFromLocal()
    }
    
    @objc func refresh(_ sender: Any) {
        loadFromLocal()
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
        loadFromLocal()
    }

}

