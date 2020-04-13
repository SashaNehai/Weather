//
//  FutureCell.swift
//  Weather
//
//  Created by Александр Нехай on 4/8/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import UIKit

class FutureCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak private var weekDay: UILabel!
    @IBOutlet weak private var maxTemp: UILabel!
    @IBOutlet weak private var minTemp: UILabel!
    
    // MARK: - Methods
    func setFutureCell(forecast: ForecastByDate) {
        weekDay.text = forecast.day
        maxTemp.text = forecast.tempMax
        minTemp.text = forecast.tempMin
    }
    
}
