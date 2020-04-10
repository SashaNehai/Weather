//
//  CellTypes.swift
//  Weather
//
//  Created by Александр Нехай on 4/8/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import Foundation

struct Section {
    let model: Weather
    let type: CellType
}

enum CellType {
    case hourly
    case future
    case text
    case additional
}
