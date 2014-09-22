//
//  YelpViewCell.swift
//  Yelp
//
//  Created by Kun Rong on 9/20/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class YelpViewCell: UITableViewCell {

    @IBOutlet weak var restaurant_Image: UIImageView!
    @IBOutlet weak var rating: UIImageView!
    @IBOutlet weak var restaurant_Name: UILabel!
    @IBOutlet weak var reviews: UILabel!
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var restaurant_Type: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
