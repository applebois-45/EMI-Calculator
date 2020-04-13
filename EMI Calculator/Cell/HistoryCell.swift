//
//  HistoryCell.swift
//  EMI Calculator
//
//  Created by Raju Kumar on 12/04/20.
//  Copyright © 2020 Indialends. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.containerView.layer.cornerRadius = 4
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor(red: 249/255, green: 249/255, blue: 252/255, alpha: 1).cgColor
        containerView.clipsToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
