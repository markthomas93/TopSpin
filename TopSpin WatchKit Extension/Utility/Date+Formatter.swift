//
//  Date+Formatter.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 8/20/19.
//

import Foundation

enum DateFormat: String {
    case shortMonthDay = "MMM d"
    case serverDateFormatISO = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
}

extension Date {
    
    public init?(iso8601String: String) {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate,
                                       .withTime,
                                       .withDashSeparatorInDate,
                                       .withColonSeparatorInTime]
        if let date = dateFormatter.date(from: iso8601String) {
            self = date
        } else {
            return nil
        }
    }
    
    func string(with format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}
