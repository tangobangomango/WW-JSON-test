//
//  TriviaModel.swift
//  WW JSON test
//
//  Created by Ed Katzman on 4/16/20.
//  Copyright © 2020 TDG. All rights reserved.
//

import Foundation

struct TriviaModel {
    let categoryName: String
    let correctResponse: String
    let cardContent: String
    let value: Int?
    
    var correctResponseString: String {
        return "What is " + correctResponse + "?"
    }
}
