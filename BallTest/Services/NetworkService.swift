//
//  NetworkService.swift
//  BallTest
//
//  Created by Developer on 9/2/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import Foundation
import Alamofire

typealias NetworkSuccessHandler = ([String: Any]?) -> Void

final class NetworkService {

    private let baseUrl = "https://8ball.delegator.com"

    private let alamofireManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
}

extension NetworkService: NetworkProvider {
    func sendRequest(_ method: HTTPMethod, request: String, successHandler: @escaping NetworkSuccessHandler) {

        var encoding: ParameterEncoding = JSONEncoding.default

        if method == .get {
            encoding = URLEncoding.default
        }

        // I don't use real question from "request" property, because technical task says "(no need to send question)"
        let path = baseUrl + "/magic/JSON/" + "good"

        let request = alamofireManager.request(path, method: method,
                                               parameters: nil, encoding: encoding,
                                               headers: nil).responseJSON { response in
            if response.result.isSuccess {
                if let data = response.result.value as? [String: AnyObject] {
                    successHandler(data)
                } else {
                    successHandler(nil)
                }
            } else {
                successHandler(nil)
            }
        }

        #if DEBUG
        print(request)
        #endif
    }
}
