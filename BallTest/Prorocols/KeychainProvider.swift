//
//  KeychainProvider.swift
//  BallTest
//
//  Created by Developer on 10/7/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import Foundation

protocol KeychainProvider {
    func eventsCountString() -> String?
    func setEventsCountString(_ countString: String)
}
