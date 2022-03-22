//
//  Ext+Date.swift
//  amazingtalker_paul
//
//  Created by 連振甫 on 2022/3/23.
//

import Foundation

extension Date {
    
    func addDay(_ value:Int) -> Date {
        let today = self
        let changeDay = Calendar.current.date(byAdding: .day, value: value, to: today)
        return changeDay!
    }
    
    func weeDay() -> String {
        
        
        let dataFormatter = DateFormatter()
        dataFormatter.locale = Locale(identifier: "zh_Hant_TW")
        dataFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let stringDate = dataFormatter.string(from: self)

        let calender = Calendar(identifier:Calendar.Identifier.gregorian)
        let comps = (calender as NSCalendar?)?.components(NSCalendar.Unit.weekday, from: self)
        
        switch (comps?.weekday ?? 0) {
        case 1:
            return "日"
        case 2:
            return "一"
        case 3:
            return "二"
        case 4:
            return "三"
        case 5:
            return "四"
        case 6:
            return "五"
        case 7:
            return "六"
        default:
            return ""
        }
    }
}
