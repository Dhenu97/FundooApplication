//
//  MenuTableViewCell.swift
//  FundooApplication
//
//  Created by BridgeLabz on 13/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var namelbl: UILabel!
}
