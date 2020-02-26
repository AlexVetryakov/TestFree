//
//  MainViewModel.swift
//  BallTest
//
//  Created by Developer on 9/29/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import Foundation
import RxSwift

final class MainViewModel {

    var answerUpdated: Observable<PresentableAnswer> {
        return model.answerUpdated.map { answer in
            answer.toPresentableAnswer()
        }
    }

    var isErrorAlertNeeded: Observable<Bool> { return model.isErrorAlertNeeded }
    var eventCountUpdated: Observable<String> { return model.eventCountUpdated.map { L10n.mainEventsCount($0) } }

    private let model: MainModel

    init(model: MainModel) {
        self.model = model
    }

    func getAnswer(to question: String) {
        model.getAnswer(to: question)
    }

    func incrementCounter() {
        model.incrementCounter()
    }
}
