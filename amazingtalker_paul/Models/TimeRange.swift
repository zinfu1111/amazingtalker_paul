//
//  TimeRange.swift
//  amazingtalker_paul
//
//  Created by 連振甫 on 2022/3/23.
//

import Foundation

struct TimeRange:Codable{
    let start: String
    let end: String
    var isAvailable:Bool? = false
}

