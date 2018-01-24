//
//  DeviceTableViewCell.swift
//  netcube
//
//  Created by fran on 18/1/17.
//  Copyright © 2017 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {

    @IBOutlet weak var theSwitch: UISwitch!
    @IBOutlet weak var deviceImageView: UIImageView!
    @IBOutlet weak var labelText: UILabel!
    
    @IBOutlet weak var statusImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.statusImage.layer.cornerRadius = self.statusImage.frame.width / 2
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
