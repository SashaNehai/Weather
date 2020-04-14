//
//  CollectionCell.swift
//  Weather
//
//  Created by Александр Нехай on 4/14/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak private var hourLabel: UILabel!
    @IBOutlet weak private var tempLabel: UILabel!
   
    // MARK: - Methods
    func setCollectionCell(forecast: ForecastByHour) {
        hourLabel.text = forecast.hour
        tempLabel.text = forecast.temp
    }
    
}

