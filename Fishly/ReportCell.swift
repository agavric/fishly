//
//  ReportCell.swift
//  Fishly
//
//  Created by Aleksandar Gavric on 5/04/2015.
//  Copyright (c) 2015 Aleksandar Gavric. All rights reserved.
//

import UIKit

class ReportCell: UITableViewCell {


    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
