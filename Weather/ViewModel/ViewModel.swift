//
//  ViewModel.swift
//  Weather
//
//  Created by Александр Нехай on 4/9/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import Foundation

// MARK: - Protocols
protocol WeatherViewModel {
    func requestWeather(lat: Double, lon: Double, comlition: @escaping (_ weatherData: Weather) -> ())
}

// MARK: - WeatherViewModelImpl
class WeatherViewModelImpl {
    
    var weatherInfo: Weather?
    
}

extension WeatherViewModelImpl: WeatherViewModel {
    
    func requestWeather(lat: Double, lon: Double, comlition: @escaping (_ weatherData: Weather) -> ()) {
        Downloader.sharedInstance.requestWeather(lat: lat, lon: lon) { (data) in
            
            let weather = Weather(cityName: data.name,
                                  temp: data.main?.temp,
                                  tempMin: data.main?.tempMin,
                                  tempMax: data.main?.tempMax,
                                  description: data.weather?.description,
                                  info: [
                                    AdditionalInfo(info: [
                                        ["Sunrise": TimeConverter.convertTimestamp(data.timezone, data.sys?.sunrise)],
                                        ["Sunset": TimeConverter.convertTimestamp(data.timezone, data.sys?.sunset)]
                                    ]),
                                    AdditionalInfo(info: [
                                        ["Cloudiness": "\(Int(data.clouds?.all ?? 0.0)) %"],
                                        ["Humidity": "\(Int(data.main?.humidity ?? 0.0)) %"]
                                    ]),
                                    AdditionalInfo(info: [
                                        ["Wind" : WindDirection.converToDirection(deg: data.wind?.deg) + " \(data.wind?.speed ?? 0.0) m/s"],
                                        ["Feels like": "\(data.main?.feelsLike ?? 0.0) Cº"]
                                    ]),
                                    AdditionalInfo(info: [
                                        ["Visability": "\(Int(data.visibility ?? 0.0)) m"],
                                        ["Pressure": "\(Int(data.main?.pressure ?? 0.0)) hPa"]
                                    ])
                ]
            )
            
            comlition(weather)
        }
    }
    
}
