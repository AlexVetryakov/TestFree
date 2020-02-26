//
//  AppCoordinator.swift
//  BallTest
//
//  Created by Developer on 10/29/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import UIKit

final class AppCoordinator: NavigationNode, FlowCoordinator {

    weak var containerViewController: UIViewController?
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window

        super.init(parent: nil)
    }

    @discardableResult
    func createFlow() -> UIViewController {
        let dataBaseService = DataBaseService()
        let networkService = NetworkService()
        let keychainService = KeychainService()
        let answerService = AnswerService(dataBaseService: dataBaseService, networkService: networkService)

        let mainCoordinator = MainFlowCoordinator(
            parent: self,
            answerService: answerService,
            keychainService: keychainService
        )
        let mainController = mainCoordinator.createFlow()
        mainCoordinator.containerViewController = mainController
        let settingsCoordinator = SettingsFlowCoordinator(
            parent: self,
            answerService: answerService
        )
        let settingsController = settingsCoordinator.createFlow()
        settingsCoordinator.containerViewController = settingsController

        let rootViewController = UITabBarController()
        rootViewController.viewControllers = [mainController, settingsController]
        containerViewController = rootViewController

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        return rootViewController
    }
}
