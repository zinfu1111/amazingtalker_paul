//
//  Ext+String.swift
//  amazingtalker_paul
//
//  Created by 連振甫 on 2022/3/23.
//

import Foundation

extension String {
    func ISOToDate() -> Date {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: self)
        return date!
    }
    
    func toDate(with formate:String) -> Date {
        let locale = NSLocale.current.languageCode
        // Create Date Formatter
        let dateFormatter = DateFormatter()
        
        // Set Date Format
        dateFormatter.dateFormat = formate
        dateFormatter.locale = Locale(identifier: locale!)
        return dateFormatter.date(from: self) ?? Date()
    }
}
