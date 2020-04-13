//
//  AdditionalCell.swift
//  Weather
//
//  Created by Александр Нехай on 4/8/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import UIKit

class AdditionalCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak private var firstTitleLabel: UILabel!
    @IBOutlet weak private var firstValueLabel: UILabel!
    @IBOutlet weak private var secondTitleLabel: UILabel!
    @IBOutlet weak private var secondValueLabel: UILabel!
    @IBOutlet weak private var stackView: UIStackView!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Methods
    func setAdditionalCell(info: AdditionalInfo) {
        let info = info.info
        
        firstTitleLabel.text = info[0].map { $0.key }[0].uppercased()
        firstValueLabel.text = info[0].map { $0.value }[0]!
        secondTitleLabel.text = info[1].map { $0.key }[0].uppercased()
        secondValueLabel.text = info[1].map { $0.value }[0]!
    }
    
}
