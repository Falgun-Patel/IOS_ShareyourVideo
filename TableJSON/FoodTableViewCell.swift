//
//  FoodTableViewCell.swift
//  TableJSON
//
//  Created by Falgun Patel on 3/20/18.
//  Copyright © 2018 Falgun Patel. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {
    @IBOutlet weak var imageViewFood: UIImageView?
    @IBOutlet weak var lblFoodName: UILabel?
    @IBOutlet weak var lblDescription: UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
