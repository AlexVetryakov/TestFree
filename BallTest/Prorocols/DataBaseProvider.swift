//
//  DataBaseProvider.swift
//  BallTest
//
//  Created by Developer on 9/29/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import Foundation

protocol DataBaseProvider {
    func getAllAnswers() -> [Answer]
    func save(answer: Answer)
    func remove(by identifier: String)
    func addObserver(_ observer: Reloadable)
    func removeObserver(_ observer: Reloadable)
}
