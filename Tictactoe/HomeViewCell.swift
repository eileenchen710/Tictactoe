//
//  HomeCell.swift
//  Tictactoe
//
//  Created by chen ya lin on 16/10/2016.
//  Copyright © 2016 W&C. All rights reserved.
//

import Foundation

import UIKit

class HomeViewCell: UITableViewCell {
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var icon: UIImageView!
   
    @IBOutlet weak var creator: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.icon.layer.cornerRadius = 40
        self.icon.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
