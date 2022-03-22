//
//  CalendarViewModel.swift
//  amazingtalker_paul
//
//  Created by 連振甫 on 2022/3/23.
//

import UIKit

class CalendarViewModel: NSObject {

    private(set) var dates = [Date]()
    
    override init() {
        super.init()
        
    }
    
    private func setFirstWeek(){
        let today = Date()
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: today)
        let weekday = dateComponents.weekday!
        
        switch weekday {
        case 1:
            dates = [today,today.addDay(1),today.addDay(2),today.addDay(3),today.addDay(4),today.addDay(5),today.addDay(6)]
        case 2:
            dates = [today.addDay(-1),today,today.addDay(1),today.addDay(2),today.addDay(3),today.addDay(4),today.addDay(5)]
        case 3:
            dates = [today.addDay(-2),today.addDay(-1),today,today.addDay(1),today.addDay(2),today.addDay(3),today.addDay(4)]
        case 4:
            dates = [today.addDay(-3),today.addDay(-2),today.addDay(-1),today,today.addDay(1),today.addDay(2),today.addDay(3)]
        case 5:
            dates = [today.addDay(-4),today.addDay(-3),today.addDay(-2),today.addDay(-1),today,today.addDay(1),today.addDay(2)]
        case 6:
            dates = [today.addDay(-5),today.addDay(-4),today.addDay(-3),today.addDay(-2),today.addDay(-1),today,today.addDay(1)]
        case 7:
            dates = [today.addDay(-6),today.addDay(-5),today.addDay(-4),today.addDay(-3),today.addDay(-2),today.addDay(-1),today]
        default:
            break
        }
        
    }
}
