//
//  TriviaViewController.swift
//  WW JSON test
//
//  Created by Ed Katzman on 4/16/20.
//  Copyright © 2020 TDG. All rights reserved.
//

import UIKit

class TriviaViewController: UITableViewController {
    
    var questionsAndAnswers: [TriviaModel] = []
    
    
    // this has to be a var because we use it below (E.g, to set the delegate)
    var triviaManager = TriviaManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("View did load")
        triviaManager.delegate = self
        print("Going to fetch")
        triviaManager.fetchTrivia()
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 100
    }


}

// MARK: - TableView delegate methods

extension TriviaViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsAndAnswers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TriviaCell", for: indexPath) as! TriviaTableViewCell
        
        let content = questionsAndAnswers[indexPath.row]
        
        
        print("updating cell")
        
        cell.answerLabel.text = content.cardContent
        cell.questionLabel.text = content.correctResponseString
        if let questionValue = content.value {
            cell.valueLabel.text = String(questionValue)
        }
        
        return cell
    }
}

// MARK: - TriviaManagerDelegate Methods

extension TriviaViewController: TriviaManagerDelegate {
    
    func didUpdateTriviaData(_ triviaManager: TriviaManager, triviaModel: [TriviaModel]) {
        DispatchQueue.main.async {
            self.questionsAndAnswers = triviaModel
            print("triviaModel returned")
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

