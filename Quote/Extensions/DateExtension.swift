//
//  DateExtension.swift
//  Quote
//
//  Created by Runhua Huang on 2024/6/27.
//

import Foundation

extension Date {
    static public func monthDayDateChinaStyle(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_CN")
        dateFormatter.dateFormat = "M月d日"
        return dateFormatter.string(from: date)
    }
    
    static public func weekdayChinaStyle(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_CN")
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    static public var currentDate: String {
        return Date.monthDayDateChinaStyle(date: Date())
    }
    
    static public var currentWeekday: String {
        return Date.weekdayChinaStyle(date: Date())
    }
}
