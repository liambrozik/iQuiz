//
//  QuizJSON.swift
//  iQuiz
//
//  Created by Liam Brozik on 2/26/19.
//  Copyright © 2019 iSchool. All rights reserved.
//

import UIKit

struct RawResponse: Decodable {
    
    struct Question: Decodable {
        let text: String
        let answer: String
        let answers: [String]
    }
    
    var title: String
    var desc: String
    var questions: [Question]
}


struct QuizJSON: Decodable {
    let title: String
    let desc: String
    let questions: [RawResponse.Question]?
    init(from decoder: Decoder) throws {
        let rawResponse = try RawResponse(from: decoder)
        
        // Now you can pick items that are important to your data model,
        // conveniently decoded into a Swift structure
        title = rawResponse.title
        desc = rawResponse.desc
        questions = rawResponse.questions
    }
}

