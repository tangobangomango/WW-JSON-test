//
//  TriviaManager.swift
//  WW JSON test
//
//  Created by Ed Katzman on 4/16/20.
//  Copyright © 2020 TDG. All rights reserved.
//

import Foundation

protocol TriviaManagerDelegate {
    
    func didUpdateTriviaData(_ triviaManager: TriviaManager, triviaModel: [TriviaModel])
    func didFailWithError(error: Error)
        
}

// needs to be a struct

struct TriviaManager {
    
    // This has to be a var as an unknown delegate
    var delegate: TriviaManagerDelegate?
    
    let triviaURL = "http://jservice.io/api/category?id=57"
    
    func fetchTrivia() {
        performRequest(with: triviaURL)
    }
    
    
    // this function a complete cut and paste except for func and var names
    func performRequest(with urlString: String) {
        
        //1 Create URL
        
        if let url = URL(string: urlString) {
            //2 Create URLSession
            let session = URLSession(configuration: .default)
            
            //3 Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    self.delegate?.didFailWithError(error: error)
                    return
                }
                
                if let safeData = data {
                    if let triviaModel = self.parseJSON(safeData) {
                        print("Parse complete")
                        self.delegate?.didUpdateTriviaData(self, triviaModel: triviaModel )
                    }
                }
            }
            //4 Start the task
            task.resume()
        }
    }
    
    
    
    func parseJSON(_ triviaData: Data) -> [TriviaModel]? {
        
        let decoder = JSONDecoder()
        
        do {
            let jsonData = try decoder.decode(TriviaData.self, from: triviaData)
            let category = jsonData.title
            let allClues = jsonData.clues
            
            var content = [TriviaModel]()
            
            for clue in allClues {
                let oneAnswer = clue.answer
                let oneQuestion = clue.question
                let oneValue = clue.value
//                print("A: \(oneAnswer) \n")
//                print("Q: \(oneQuestion) \n")
//                print("V: \(String(describing: oneValue)) \n")
                if category != "" && oneAnswer != "" && oneQuestion != "" && oneValue != nil {
                  content.append(TriviaModel(categoryName: category, correctResponse: oneAnswer, cardContent: oneQuestion, value: oneValue))
                }
                
            }
            
//            let answer = jsonData.clues[0].answer
//            let question = jsonData.clues[0].question
//            let value = jsonData.clues[0].value
//            
//            let content = TriviaModel(categoryName: category, correctResponse: answer, cardContent: question, value: value)
//            let content = TriviaModel(categoryName: category)
            
            return content
        }  catch let error {
            
            delegate?.didFailWithError(error: error)
            return nil
            
        }
    }
}
