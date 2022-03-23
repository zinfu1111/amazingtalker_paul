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
    
    enum CodingKeys: String, CodingKey {
        case available
        case booked
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let availableData = try values.decode([TimeRange].self, forKey: .available)
        let bookedData = try values.decode([TimeRange].self, forKey: .booked)
        self.available = availableData.map { item -> TimeRange in
            var data = item
            data.isAvailable = true
            return data
        }
        self.booked = bookedData.map { item -> TimeRange in
            var data = item
            data.isAvailable = false
            return data
        }
    }
    
    let available: [TimeRange]
    let booked: [TimeRange]
}
