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
    @IBOutlet weak private var weekDayLabel: UILabel!
    @IBOutlet weak private var maxTempLabel: UILabel!
    @IBOutlet weak private var minTempLabel: UILabel!
    
    // MARK: - Methods
    func setFutureCell(forecast: ForecastByDate) {
        weekDayLabel.text = forecast.day
        maxTempLabel.text = forecast.tempMax
        minTempLabel.text = forecast.tempMin
    }
    
}
