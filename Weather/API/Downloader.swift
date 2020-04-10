//
//  Downloader.swift
//  Weather
//
//  Created by Александр Нехай on 4/9/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import Foundation

class Downloader {
    
    // MARK: - Constants
    static let sharedInstance = Downloader()
    let session = URLSession(configuration: .default)
    
    // MARK: - Methods
    func requestWeather(lat: Double, lon: Double, comlition: @escaping (_ weatherData: WeatherData) -> ()) {
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&appid=\(Constants.apiKey)") else { return }
        
        let dataTask = session.dataTask(with: url) { (data, responce, error) in
            if let data = data, error == nil {
                var weatherData = WeatherData()
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let weather = try decoder.decode(WeatherData.self, from: data)
                    weatherData = weather
                    print(weather)
                } catch {
                    print("Error on download weather")
                }
                
                DispatchQueue.main.async {
                    comlition(weatherData)
                }
            }
        }
        
        dataTask.resume()
    }
}
