//
//  allUserCellTableViewCell.swift
//  Tictactoe
//
//  Created by 王益民 on 10/16/16.
//  Copyright © 2016 W&C. All rights reserved.
//

import UIKit

class allUserCellTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var userimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
