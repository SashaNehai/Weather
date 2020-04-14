//
//  Weather.swift
//  Weather
//
//  Created by Александр Нехай on 4/9/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import Foundation

struct Weather: Codable {
    var temp: String?
    var forecast: [ForecastByDate]?
    var main: String?
    var description: String?
    var info: [AdditionalInfo]?
    var hourForecast: [ForecastByHour]?
}

struct AdditionalInfo: Codable {
    var info: [[String : String?]]
}

struct ForecastByDate: Codable {
    var day: String
    var main: String
    var tempMax: String
    var tempMin: String
}

struct ForecastByHour: Codable {
    var timestamp: Int?
    var hour: String?
    var main: String
    var temp: String
}
