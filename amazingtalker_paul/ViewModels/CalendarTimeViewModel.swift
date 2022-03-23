//
//  CalendarTimeViewModel.swift
//  amazingtalker_paul
//
//  Created by 連振甫 on 2022/3/23.
//

import UIKit

class CalendarTimeViewModel: NSObject {

    let isAvailable:Bool
    let time:Date
    
    init(isAvailable:Bool,time:Date) {
        self.isAvailable = isAvailable
        self.time = time
    }
}
