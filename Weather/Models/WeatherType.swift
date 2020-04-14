//
//  WeatherType.swift
//  Weather
//
//  Created by Александр Нехай on 4/14/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import Foundation
import UIKit

enum WeatherType: String {
    case Clear
    case Clouds
    case Rain
    case Snow
    case Sunrise
    case Sunset
    
    var image: UIImage? {
        switch self {
        case .Clear:
            return UIImage(systemName: "sun.max.fill")
        case .Clouds:
            return UIImage(systemName: "cloud")
        case .Rain:
            return UIImage(systemName: "cloud.rain")
        case .Snow:
            return UIImage(systemName: "snow")
        case .Sunrise:
            return UIImage(systemName: "sunrise")
        case .Sunset:
            return UIImage(systemName: "sunset")
        }
    }
}
