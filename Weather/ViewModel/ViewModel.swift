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
class WeatherViewModelImpl { }

extension WeatherViewModelImpl: WeatherViewModel {
    
    func requestWeather(lat: Double, lon: Double, comlition: @escaping (_ weatherData: Weather) -> ()) {
        Downloader.sharedInstance.requestWeather(lat: lat, lon: lon) { (data) in
            
            let weather = Weather(temp: "\(Int(data.current?.temp ?? 0.0))",
                forecast: data.daily.map({ (dailyForecast) -> [ForecastByDate] in
                    return dailyForecast.map { (dayForecast) -> ForecastByDate in
                        
                        return ForecastByDate(day: TimeConverter.convertTimestampToWeekDay(dayForecast.dt) ?? "",
                                              tempMax: "\(Int(dayForecast.temp?.max ?? 0))",
                                              tempMin: "\(Int(dayForecast.temp?.min ?? 0))")
                    }
                }),
                description: "Today: " + (data.current?.weather?[0].description?.capitalized ?? ""),
                info: [
                    AdditionalInfo(info: [
                        ["Sunrise": TimeConverter.convertTimestampToTime(data.timezone, data.current?.sunrise)],
                        ["Sunset": TimeConverter.convertTimestampToTime(data.timezone, data.current?.sunset)]
                    ]),
                    AdditionalInfo(info: [
                        ["Cloudiness": "\(Int(data.current?.clouds ?? 0.0)) %"],
                        ["Humidity": "\(Int(data.current?.humidity ?? 0.0)) %"]
                    ]),
                    AdditionalInfo(info: [
                        ["Wind" : WindDirection.converToDirection(deg: data.current?.windDeg) + " \(data.current?.windSpeed ?? 0.0) m/s"],
                        ["Feels like": "\(Int(data.current?.feelsLike ?? 0.0)) Cº"]
                    ]),
                    AdditionalInfo(info: [
                        ["Precipitation": "\(Int(data.current?.rain ?? 0.0)) mm"],
                        ["Pressure": "\(Int(data.current?.pressure ?? 0.0)) hPa"]
                    ]),
                    AdditionalInfo(info: [
                        ["Visability": "\(Int(data.current?.visibility ?? 0.0)) m"],
                        ["UV Index": "\(Int(data.current?.uvi ?? 0.0))"]
                    ])
                ],
                hourForecast: data.hourly.map({ (hourForecast) -> [ForecastByHour] in
                    return hourForecast.map { (hourForecast) ->  ForecastByHour in
                        
                        return ForecastByHour(hour: TimeConverter.convertTimestampToTime(data.timezone, hourForecast.dt) ?? "UTC",
                                              temp: "\(Int(hourForecast.temp ?? 0.0))º")
                    }
                    
                }))
            
            comlition(weather)
        }
    }
    
}
