//
//  CalendarDataManager.swift
//  amazingtalker_paul
//
//  Created by 連振甫 on 2022/3/23.
//

import Foundation

class CalendarDataManager {
    
    static let shared = CalendarDataManager()
    
    var dates = [Date]()
    
    init() {
        let today = Date()
        dates = generalWeek(with: today)
    }
    
    func preWeekDates() {
        
        guard dates.count > 0 else { return }
        
        let currentFirstDate = dates.first!
        let preWeekLastDay = currentFirstDate.addDay(-1)
        dates = generalWeek(with: preWeekLastDay)
    }
    
    func nextWeekDates() {
        guard dates.count > 0 else { return }
        
        let currentLastDate = dates.last!
        let nextWeekFirstDay = currentLastDate.addDay(1)
        dates = generalWeek(with: nextWeekFirstDay)
    }
    
    func generalWeek(with date:Date) -> [Date] {
        
        var res = [Date]()
        
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: date)
        let weekday = dateComponents.weekday!
        let allWeekday = [1,2,3,4,5,6,7]
        
        for item in allWeekday {
            let addValue = item - weekday 
            let day = date.addDay(addValue)
            res.append(day)
        }
        
        return res
    }
    
}
