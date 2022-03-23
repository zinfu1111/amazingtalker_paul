//
//  CalendarControlCell.swift
//  amazingtalker_paul
//
//  Created by 連振甫 on 2022/3/23.
//

import UIKit

class CalendarControlCell: UITableViewCell {

    @IBOutlet weak var dateRangeLabel: UILabel!
    @IBOutlet weak var timezoneLabel: UILabel!
    @IBOutlet weak var preWeekButton: UIButton!
    
    var preWeekClousure = {}
    var nextWeekClousure = {}
    
    @IBAction func preWeek(_ sender: Any) {
        preWeekClousure()
    }
    @IBAction func nextWeek(_ sender: Any) {
        nextWeekClousure()
    }
}
