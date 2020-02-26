//
//  FlowCoordinator.swift
//  BallTest
//
//  Created by Developer on 10/30/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import UIKit

protocol FlowCoordinator: class {

    var containerViewController: UIViewController? { get set }

    @discardableResult
    func createFlow() -> UIViewController
}
