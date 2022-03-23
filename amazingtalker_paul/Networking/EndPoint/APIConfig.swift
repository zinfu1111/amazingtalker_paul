//
//  APIConfig.swift
//  DemoNetworkLayer
//
//  Created by Paul on 2022/3/15.
//

import Foundation

enum Environment: String {
//    case local = ""
    case dev = ""
    case product = "https://tw.amazingtalker.com"
}

enum APIMethod: String {
    case schedule = "/v1/guest/teachers/amy-estrada/schedule"
}
