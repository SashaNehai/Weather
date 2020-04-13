//
//  CollectionViewCell.swift
//  Weather
//
//  Created by Александр Нехай on 4/13/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak private var hour: UILabel!
    @IBOutlet weak private var temp: UILabel!
    
    func setCollectionCell(forecast: ForecastByHour) {
        hour.text = forecast.hour
        temp.text = forecast.temp
    }
    
}
