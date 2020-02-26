//
//  SettingsViewModel.swift
//  BallTest
//
//  Created by Developer on 9/29/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

final class SettingsViewModel {

    var dataSourceUpdated: Observable<[AnimatableSectionModel<String, PresentableAnswer>]> {
        return model.modelsUpdated.map { answers in
            let presentableAnswers = answers.map { $0.toPresentableAnswer() }
            return [AnimatableSectionModel(model: "", items: presentableAnswers)]
        }
    }

    private let disposeBag = DisposeBag()
    private let model: SettingsModel

    init(model: SettingsModel) {
        self.model = model
    }

    func getAnswers() {
        model.getDefaultAnswers()
    }

    func removeAnswer(at index: Int) {
        model.removeAswer(at: index)
    }

    func addAnswer(with text: String) {
        model.addAnswer(with: text)
    }
}
