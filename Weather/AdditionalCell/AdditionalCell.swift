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
    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var firstValueLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var secondValueLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Methods
    func setAdditionalCell(info: AdditionalInfo) {
        let info = info.info
        
        firstTitleLabel.text = info[0].map { $0.key }[0]
        firstValueLabel.text = info[0].map { $0.value }[0]!
        secondTitleLabel.text = info[1].map { $0.key }[0]
        secondValueLabel.text = info[1].map { $0.value }[0]!
    }
    
}
