//
//  SettingsModel.swift
//  BallTest
//
//  Created by Developer on 9/29/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

final class SettingsModel {

    var modelsUpdated: Observable<[Answer]> { return answers.asObservable() }

    private let answerService: AnswerProvider
    private let answers = BehaviorRelay(value: [Answer]())

    init(answerService: AnswerProvider) {
        self.answerService = answerService
        self.answerService.addObserver(self)
    }

    deinit {
        answerService.removeObserver(self)
    }

    func getDefaultAnswers() {
        answers.accept(answerService.getDefaultAnswers())
    }

    func removeAswer(at index: Int) {
        answerService.removeAnswer(by: answers.value[index].identifier)
    }

    func addAnswer(with text: String) {
        answerService.addAnswer(with: text)
    }
}

extension SettingsModel: Reloadable {
    func reload() {
        answers.accept(answerService.getDefaultAnswers())
    }
}
