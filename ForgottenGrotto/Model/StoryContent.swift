//
//  StoryContent.swift
//  ForgottenGrotto
//
//  Created by Brendan on 2021-08-13.
//

import Foundation

struct NextOption: Decodable {
    let id: Int
    let content: String
}

struct StoryContent: Decodable {
    let id: Int
    let content: String
    let isGameOver: Bool
    let nextOptions: [NextOption]

    var nextIds: [Int] {
        nextOptions.map { $0.id }
    }
}
