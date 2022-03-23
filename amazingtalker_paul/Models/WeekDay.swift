//
//  WeekDay.swift
//  amazingtalker_paul
//
//  Created by 連振甫 on 2022/3/24.
//

import Foundation

enum WeekDay:Int {
    case Sunday = 1
    case Monday = 2
    case Tuesday = 3
    case Wednesday = 4
    case Thursday = 5
    case Friday = 6
    case Saturday = 7
    
    func getText() -> String {
        switch self {
        case .Sunday:
            return "日"
        case .Monday:
            return "一"
        case .Tuesday:
            return "二"
        case .Wednesday:
            return "三"
        case .Thursday:
            return "四"
        case .Friday:
            return "五"
        case .Saturday:
            return "六"
        }
    }
}
