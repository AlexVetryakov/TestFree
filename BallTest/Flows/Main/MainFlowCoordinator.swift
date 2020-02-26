//
//  MainFlowCoordinator.swift
//  BallTest
//
//  Created by Developer on 10/29/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import UIKit

final class MainFlowCoordinator: NavigationNode, FlowCoordinator {

    weak var containerViewController: UIViewController?
    private let answerService: AnswerService
    private let keychainService: KeychainService

    init(parent: NavigationNode, answerService: AnswerService, keychainService: KeychainService) {
        self.answerService = answerService
        self.keychainService = keychainService

        super.init(parent: parent)
    }

    @discardableResult
    func createFlow() -> UIViewController {
        let mainModel = MainModel(answerService: answerService, keychainService: keychainService)
        let mainViewModel = MainViewModel(model: mainModel)
        let mainViewController = MainViewController(viewModel: mainViewModel)
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)

        return mainNavigationController
    }
}
