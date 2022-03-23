//
//  Ext+String.swift
//  amazingtalker_paul
//
//  Created by 連振甫 on 2022/3/23.
//

import Foundation

extension String {
    func ISOStringToDate() -> Date {
        let locale = NSLocale.current.identifier
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: locale)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = formatter.date(from: self)
        
        return date!
    }
    
    func toDate(with formate:String) -> Date {
        let locale = NSLocale.current.identifier
        // Create Date Formatter
        let dateFormatter = DateFormatter()
        
        // Set Date Format
        dateFormatter.dateFormat = formate
        dateFormatter.locale = Locale(identifier: locale)
        return dateFormatter.date(from: self) ?? Date()
    }
}
