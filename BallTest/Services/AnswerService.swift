//
//  AnswerService.swift
//  BallTest
//
//  Created by Developer on 9/2/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import Foundation

typealias AnswerComplitionHandler = (Answer?) -> Void
private let defaultAswersInitializedUDKey = "defaultAswersInitializedUDKey"

final class AnswerService {

    private let dataBaseService: DataBaseProvider
    private let networkService: NetworkProvider

    init(dataBaseService: DataBaseService, networkService: NetworkService) {
        self.dataBaseService = dataBaseService
        self.networkService = networkService

        let isDefaultAswersInitialized = UserDefaults.standard.bool(forKey: defaultAswersInitializedUDKey)

        if !isDefaultAswersInitialized {
            let answers = defaultAnswers()
            answers.forEach { answer in
                self.dataBaseService.save(answer: answer)
            }
            UserDefaults.standard.set(true, forKey: defaultAswersInitializedUDKey)
        }
    }

    private func getRandomAnswer() -> Answer? {
        let answersDB = dataBaseService.getAllAnswers()

        return answersDB.randomElement()
    }

    private func defaultAnswers() -> [Answer] {
        let answer1 = Answer(identifier: UUID().uuidString, text: L10n.firstAnswer)
        let answer2 = Answer(identifier: UUID().uuidString, text: L10n.secondAnswer)
        let answer3 = Answer(identifier: UUID().uuidString, text: L10n.thirdAnswer)

        return [answer1, answer2, answer3]
    }
}

extension AnswerService: AnswerProvider {
    func addObserver(_ observer: Reloadable) {
        dataBaseService.addObserver(observer)
    }

    func removeObserver(_ observer: Reloadable) {
        dataBaseService.removeObserver(observer)
    }

    func getAnswer(to question: String, complition: @escaping AnswerComplitionHandler) {
        networkService.sendRequest(.get, request: question) { [weak self] response in
            if response != nil {
                if let data = response, let answer = data["magic"] as? [String: Any],
                    let text = answer["answer"] as? String {
                    let answer = Answer(identifier: UUID().uuidString, text: text, date: Date())
                    self?.dataBaseService.save(answer: answer)
                    complition(answer)
                } else {
                    complition(self?.getRandomAnswer())
                }
            } else {
                complition(self?.getRandomAnswer())
            }
        }
    }

    func getDefaultAnswers() -> [Answer] {
        return dataBaseService.getAllAnswers()
    }

    func removeAnswer(by identifier: String) {
        dataBaseService.remove(by: identifier)
    }

    func addAnswer(with text: String) {
        let answer = Answer(identifier: UUID().uuidString, text: text)

        dataBaseService.save(answer: answer)
    }
}
