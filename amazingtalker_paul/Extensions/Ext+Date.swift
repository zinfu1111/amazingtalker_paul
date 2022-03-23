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
    
    func addMin(_ value:Int) -> Date {
        let today = self
        let changeDay = Calendar.current.date(byAdding: .minute, value: value, to: today)
        return changeDay!
    }
    
    func weekDayText() -> String {
        
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: self)
        let weekday = dateComponents.weekday!
        switch (weekday) {
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
    
    
    func getFormatter(format:String) -> String {
        
        let locale = NSLocale.current.languageCode
        // Create Date Formatter
        let dateFormatter = DateFormatter()
        
        // Set Date Format
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: locale!)
        return dateFormatter.string(from: self)
    }
    
    func toTimezone() -> String {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.string(from: self)
        return date
    }
}
