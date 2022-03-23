//
//  Schedule.swift
//  amazingtalker_paul
//
//  Created by 連振甫 on 2022/3/23.
//

import Foundation

struct Schedule:Codable {
    
    internal init(available: [TimeRange], booked: [TimeRange]) {
        self.available = available
        self.booked = booked
    }
    
    let available: [TimeRange]
    let booked: [TimeRange]
}
