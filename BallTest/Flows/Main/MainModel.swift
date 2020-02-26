//
//  MainModel.swift
//  BallTest
//
//  Created by Developer on 9/29/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

private let eventDefaultCount = "0"

final class MainModel {

    var answerUpdated: Observable<Answer> { return answer.asObservable() }
    var isErrorAlertNeeded: Observable<Bool> { return failedResult.distinctUntilChanged() }
    var eventCountUpdated: Observable<String> { return eventsCount.asObservable() }

    private let failedResult = PublishRelay<Bool>()
    private let answer = PublishRelay<Answer>()
    private let eventsCount: BehaviorRelay<String>
    private let answerService: AnswerProvider
    private let keychainService: KeychainProvider

    init(answerService: AnswerProvider, keychainService: KeychainProvider) {
        self.answerService = answerService
        self.keychainService = keychainService

        eventsCount = BehaviorRelay(value: keychainService.eventsCountString() ?? eventDefaultCount)
    }

    func getAnswer(to text: String) {
        failedResult.accept(false)
        answerService.getAnswer(to: text) { [weak self] answer in
            guard let answer = answer else {
                self?.failedResult.accept(true)
                return
            }
            self?.answer.accept(answer)
        }
    }

    func incrementCounter() {
        guard let count = Int(eventsCount.value) else { return }
        let result = "\(count + 1)"
        eventsCount.accept(result)
        keychainService.setEventsCountString(result)
    }
}
