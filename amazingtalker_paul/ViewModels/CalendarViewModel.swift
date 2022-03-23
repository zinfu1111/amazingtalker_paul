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
        let todayFormatter = Date().getFormatter(format: DateTimeFormatter.YearDashDate)
        let today = todayFormatter.toDate(with: DateTimeFormatter.YearDashDate)
        let targetFormatter = day.getFormatter(format: DateTimeFormatter.YearDashDate)
        let target = targetFormatter.toDate(with: DateTimeFormatter.YearDashDate)
        
        switch target.compare(today) {
        case .orderedAscending:
            return true
        case .orderedDescending,.orderedSame:
            return false
        }
    }
    
    func initWeekDate() {
        let today = Date()
        dates = getWeekDates(with: WeekDay.Sunday.rawValue,by: today)
    }
    
    func preWeekDates() {
        
        guard dates.count > 0 else { return }
        
        let currentFirstDate = dates.first!
        let preWeekLastDay = currentFirstDate.addDay(-1)
        dates = getWeekDates(with: WeekDay.Sunday.rawValue,by: preWeekLastDay)
    }
    
    func nextWeekDates() {
        guard dates.count > 0 else { return }
        
        let currentLastDate = dates.last!
        let nextWeekFirstDay = currentLastDate.addDay(1)
        dates = getWeekDates(with: WeekDay.Sunday.rawValue,by: nextWeekFirstDay)
    }
    
    
    /// 取得傳入日期的當週資料
    /// - Parameters:
    ///   - firstWeekDay: 設定一週的第一天為星期幾
    ///   - date: 傳入日期
    /// - Returns: 一週的日期
    func getWeekDates(with firstWeekDay:Int,by date:Date) -> [Date] {
        
        //1.找出傳入日期是星期幾
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: date)
        let weekday = dateComponents.weekday!
        
        //2.與本週的第一天差幾天
        let differenceFromFirstWeekDay = firstWeekDay - weekday
        
        //3.用傳入的日期加上差異天數找到第一天的日期
        let firstWeekDate = date.addDay(differenceFromFirstWeekDay)
        
        var res = [Date]()
        //4.一週有7天全部放到回傳的參數
        for i in 0...6 {
            let date = firstWeekDate.addDay(i)
            res.append(date)
        }
        
        return res
    }
    
    
    /// 將api的時間範圍以每半小時為單位取出後並賦予狀態
    /// - Returns:時間資料
    func generalTimeViewModel() -> [CalendarTimeViewModel] {
        
        let times = self.scheduleData.available+self.scheduleData.booked
        
        var res = [CalendarTimeViewModel]()
        
        for time in times {
            let endTime = time.end.ISOStringToDate()
            var currentTime = time.start.ISOStringToDate()
            while currentTime.compare(endTime) != .orderedSame {
                res.append(CalendarTimeViewModel(isAvailable: time.isAvailable ?? false, time: currentTime))
                currentTime = currentTime.addMin(30)
            }
        }
        return res
    }
}
