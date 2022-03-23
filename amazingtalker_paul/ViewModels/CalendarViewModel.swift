//
//  CalendarViewModel.swift
//  amazingtalker_paul
//
//  Created by 連振甫 on 2022/3/23.
//

import UIKit

class CalendarViewModel: NSObject {

    private(set) var dates = [Date](){
        didSet{
            lockPreWeek = isPast(day: dates.first!.addDay(-1))
            fetchData(with: completionUpdateUI)
        }
    }
    private(set) var scheduleData:Schedule!
    private(set) var lockPreWeek:Bool!
    private var restManager:RestManager!
    var completionUpdateUI:(()->Void)?
    
    override init() {
        super.init()
        lockPreWeek = true
        restManager = RestManager()
        scheduleData = Schedule(available: [], booked: [])
    }
    
    func fetchData(with completionHandler:(()->Void)?) {
        let startTime = self.dates.first!.toTimezone()
        restManager.requestJSONDataByURL(.schedule, ["started_at":startTime], resType: Schedule.self) {[weak self] response, error in
            guard let self = self else { return }
            guard let response = response,error == nil else { return }
            self.scheduleData = response
            completionHandler?()
        }
    }
    
    func isPast(day:Date) -> Bool {
        let formate = "YYYY/MM/dd"
        let todayFormatter = Date().getFormatter(format: formate)
        let today = todayFormatter.toDate(with: formate)
        let targetFormatter = day.getFormatter(format: formate)
        let target = targetFormatter.toDate(with: formate)
        
        switch target.compare(today) {
        case .orderedAscending:
            return true
        case .orderedDescending,.orderedSame:
            return false
        }
    }
    
    func initWeekDate() {
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
