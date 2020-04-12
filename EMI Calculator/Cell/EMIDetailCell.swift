//
//  EMIDetailHeaderCell.swift
//  EMI Calculator
//
//  Created by Raju Kumar on 12/04/20.
//  Copyright © 2020 Indialends. All rights reserved.
//

import UIKit

class EMIDetailCell: UITableViewCell {

    @IBOutlet weak var balanceLbl: UILabel!
    @IBOutlet weak var interestLbl: UILabel!
    @IBOutlet weak var principalLbl: UILabel!
    
    @IBOutlet weak var monthLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
