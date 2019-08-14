//
//  SideMenuCell.swift
//  FundooApplication
//
//  Created by BridgeLabz on 27/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBOutlet weak var imageLbl: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
}
