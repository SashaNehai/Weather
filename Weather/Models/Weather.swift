//
//  Weather.swift
//  Weather
//
//  Created by Александр Нехай on 4/9/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import Foundation

struct Weather {
    var temp: String?
    var forecast: [ForecastByDate]?
    var description: String?
    var info: [AdditionalInfo]?
    var hourForecast: [ForecastByHour]?
}

struct AdditionalInfo {
    var info: [[String : String?]]
}

struct ForecastByDate {
    var day: String
    var tempMax: String
    var tempMin: String
}

struct ForecastByHour {
    var hour: String
    var temp: String
}
