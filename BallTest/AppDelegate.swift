//
//  AppDelegate.swift
//  BallTest
//
//  Created by Developer on 9/2/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = Asset.Colors.dark.color

        appCoordinator = AppCoordinator(window: window!)
        appCoordinator.createFlow()

        UIApplication.shared.applicationSupportsShakeToEdit = false

// minimal Realm migration
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: nil)
        Realm.Configuration.defaultConfiguration = config

        return true
    }
}
