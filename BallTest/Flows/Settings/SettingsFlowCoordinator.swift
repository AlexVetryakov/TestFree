//
//  SettingsFlowCoordinator.swift
//  BallTest
//
//  Created by Developer on 10/29/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import UIKit

final class SettingsFlowCoordinator: NavigationNode, FlowCoordinator {

    weak var containerViewController: UIViewController?
    private let answerService: AnswerService

    init(parent: NavigationNode, answerService: AnswerService) {
        self.answerService = answerService

        super.init(parent: parent)
    }

    @discardableResult
    func createFlow() -> UIViewController {
        let settingsModel = SettingsModel(answerService: answerService)
        let settingsViewModel = SettingsViewModel(model: settingsModel)
        let settingsViewController = SettingsViewController(viewModel: settingsViewModel)
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)

        return settingsNavigationController
    }
}
