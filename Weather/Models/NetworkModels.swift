//
//  NetworkModels.swift
//  Weather
//
//  Created by Александр Нехай on 4/9/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    var weather: [WeatherDescription]?
    var main: MainWeatherData?
    var visibility: Double?
    var wind: WindInfo?
    var clouds: Clouds?
    var sys: SunInfo?
    var timezone: Int?
    var name: String?
}

struct WeatherDescription: Decodable {
    var description: String
}

struct MainWeatherData: Decodable {
    var temp: Double
    var feelsLike: Double
    var tempMin: Double
    var tempMax: Double
    var pressure: Double
    var humidity: Double
}

struct WindInfo: Decodable {
    var speed: Double?
    var deg: Double?
}

struct Clouds: Decodable {
    var all: Double
}

struct SunInfo: Decodable {
    var sunrise: Int
    var sunset: Int
}


