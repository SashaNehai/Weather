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
            let sunrise = TimeConverter.convertTimestampToTime(data.timezone, data.current?.sunrise)
            let sunset = TimeConverter.convertTimestampToTime(data.timezone, data.current?.sunset)
            
            let weather = Weather(temp: "\(Int(data.current?.temp ?? 0.0))º",
                forecast: data.daily.map({ (dailyForecast) -> [ForecastByDate] in
                    return dailyForecast.map { (dayForecast) -> ForecastByDate in
                        
                        return ForecastByDate(
                            day: TimeConverter.convertTimestampToWeekDay(dayForecast.dt) ?? "",
                            main: dayForecast.weather?[0].main ?? "",
                            tempMax: "\(Int(dayForecast.temp?.max ?? 0))",
                            tempMin: "\(Int(dayForecast.temp?.min ?? 0))"
                        )
                    }
                }),
                main: data.current?.weather?[0].main?.capitalized ?? "",
                description: "Today: " + (data.current?.weather?[0].description?.capitalized ?? ""),
                info: [
                    AdditionalInfo(info: [
                        ["Sunrise": sunrise],
                        ["Sunset": sunset]
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
                        ["Visability": "\((data.current?.visibility ?? 0.0) / 1000) km"],
                        ["UV Index": "\(Int(data.current?.uvi ?? 0.0))"]
                    ])
                ],
                hourForecast: data.hourly.map({ (hourForecast) -> [ForecastByHour] in
                    
                    var hourForecast = hourForecast.map { (hourForecast) ->  ForecastByHour in
                        return ForecastByHour(
                            timestamp: hourForecast.dt,
                            hour: TimeConverter.convertTimestampToHour(data.timezone, hourForecast.dt),
                            main: hourForecast.weather?[0].main ?? "",
                            temp: "\(Int(hourForecast.temp ?? 0.0))º"
                        )
                    }
                    
                    hourForecast.insert(ForecastByHour(timestamp: data.current?.sunrise, hour: sunrise, main: "Sunrise", temp: "Sunrise"), at: 0)
                    hourForecast.insert(ForecastByHour(timestamp: data.current?.sunset, hour: sunset, main: "Sunset", temp: "Sunset"), at: 0)
                    hourForecast = hourForecast.sorted { $0.timestamp ?? 0 < $1.timestamp ?? 0 }
                    
                    _ = hourForecast[0].main == "Sunrise" ? hourForecast.removeFirst() : nil
                    _ = hourForecast[0].main == "Sunset" ? hourForecast.removeFirst() : nil
                    
                    return hourForecast
                }))
            
            comlition(weather)
        }
    }
    
}
