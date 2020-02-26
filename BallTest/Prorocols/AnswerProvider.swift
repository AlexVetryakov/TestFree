//
//  Answerable.swift
//  BallTest
//
//  Created by Developer on 9/29/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import Foundation

protocol AnswerProvider {
    func getAnswer(to question: String, complition: @escaping AnswerComplitionHandler)
    func getDefaultAnswers() -> [Answer]
    func removeAnswer(by identifier: String)
    func addAnswer(with text: String)
    func addObserver(_ observer: Reloadable)
    func removeObserver(_ observer: Reloadable)
}
