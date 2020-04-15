//
//  HistoryCell.swift
//  EMI Calculator
//
//  Created by Raju Kumar on 12/04/20.
//  Copyright © 2020 Indialends. All rights reserved.
//

import UIKit

class DeleteHistoryCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var emiLbl: UILabel!
    @IBOutlet weak var emiDetailLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.containerView.layer.cornerRadius = 4
        containerView.layer.borderWidth = 1
        containerView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        containerView.clipsToBounds = true
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor(red: 218/255, green: 223/255, blue: 234/255, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
