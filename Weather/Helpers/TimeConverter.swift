//
//  TimeConverter.swift
//  Weather
//
//  Created by Александр Нехай on 4/9/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import Foundation

class TimeConverter {

    // MARK: - Methods
    static func convertTimestampToTime(_ timezone: String?,_ timestamp: Int?) -> String? {
        guard let timezone = timezone, let timestamp = timestamp else { return nil }
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(identifier: timezone)
        return formatter.string(from: date)
    }
    
    static func convertTimestampToHour(_ timezone: String?,_ timestamp: Int?) -> String? {
        var result = convertTimestampToTime(timezone, timestamp)
        result = result?.replacingOccurrences(of: ":00", with: "")
        return result
    }

    static func convertTimestampToWeekDay(_ timestamp: Int?) -> String? {
        guard let timestamp = timestamp else { return nil }
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
    
}
