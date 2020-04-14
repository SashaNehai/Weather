//
//  NetworkModels.swift
//  Weather
//
//  Created by Александр Нехай on 4/9/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import Foundation

struct WeatherForecast: Decodable {
    var timezone: String?
    var current: CurrentWeatherData?
    var hourly: [HourlyWeatherData]?
    var daily: [DailyWeatherData]?
}

struct CurrentWeatherData: Decodable {
    var dt: Int?
    var sunrise: Int?
    var sunset: Int?
    var temp: Double?
    var feelsLike: Double?
    var pressure: Double?
    var humidity: Double?
    var rain: Double?
    var uvi: Double?
    var clouds: Double?
    var visibility: Double?
    var windSpeed: Double?
    var windDeg: Double?
    var weather: [WeatherDescription]?
}

struct WeatherDescription: Decodable {
    var main: String?
    var description: String?
}

struct HourlyWeatherData: Decodable {
    var dt: Int?
    var temp: Double?
}

struct DailyWeatherData: Decodable {
    var dt: Int?
    var temp: Temperature?
}

struct Temperature: Decodable {
    var min: Double?
    var max: Double?
}

