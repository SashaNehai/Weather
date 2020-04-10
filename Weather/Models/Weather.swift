//
//  Weather.swift
//  Weather
//
//  Created by Александр Нехай on 4/9/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import Foundation

struct Weather {
    var cityName: String?
    var temp: Double?
    var tempMin: Double?
    var tempMax: Double?
    var description: String?
    var info: [AdditionalInfo]?
}

struct AdditionalInfo {
    var info: [[String : String?]]
}
