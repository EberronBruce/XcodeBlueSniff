//
//  BlueToothTableViewCell.swift
//  BlueSniff
//
//  Created by Bruce Burgess on 3/16/16.
//  Copyright © 2016 Bruce Burgess. All rights reserved.
//

import UIKit

class BlueToothTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
