//
//  KeychainService.swift
//  BallTest
//
//  Created by Developer on 10/7/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import Foundation
import KeychainSwift

private let userEventsCountKey = "userEventsCountKey"

final class KeychainService {
    private let keychain = KeychainSwift()
}

extension KeychainService: KeychainProvider {
    func eventsCountString() -> String? {
        return keychain.get(userEventsCountKey)
    }

    func setEventsCountString(_ countString: String) {
        keychain.set(countString, forKey: userEventsCountKey)
    }
}
