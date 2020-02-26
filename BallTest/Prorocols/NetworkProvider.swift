//
//  NetworkProvider.swift
//  BallTest
//
//  Created by Developer on 9/29/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkProvider {
    func sendRequest(_ method: HTTPMethod, request: String, successHandler: @escaping NetworkSuccessHandler)
}
