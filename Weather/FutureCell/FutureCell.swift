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
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Methods
    func setFutureCell() {
        
    }
    
}
