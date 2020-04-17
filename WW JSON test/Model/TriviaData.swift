//
//  TriviaData.swift
//  WW JSON test
//
//  Created by Ed Katzman on 4/16/20.
//  Copyright © 2020 TDG. All rights reserved.
//

import Foundation

struct TriviaData: Decodable {
    let id: Int
    let title: String
    let clues: [AnswerQuestion]
}

struct AnswerQuestion: Decodable {
    let answer: String
    let question: String
    let value: Int?
}
