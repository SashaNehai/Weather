//
//  TimeConverter.swift
//  Weather
//
//  Created by Александр Нехай on 4/9/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import Foundation

class TimeConverter {

    static func convertTimestamp(_ timezone: Int?,_ timestamp: Int?) -> String? {
        guard let timezone = timezone, let timestamp = timestamp else { return nil }
        
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(secondsFromGMT: timezone)
        return formatter.string(from: date)
    }
    
}
