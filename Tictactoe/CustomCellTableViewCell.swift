//
//  CustomCellTableViewCell.swift
//  Todo List
//
//  Created by chenyalin on 10/8/16.
//  Copyright © 2016 COMP5216. All rights reserved.
//

import UIKit

class CustomCellTableViewCell: UITableViewCell {
    
    @IBOutlet var photo: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var number: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet var des: UILabel!
    
    @IBAction func checkDetail(_ sender: AnyObject) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
