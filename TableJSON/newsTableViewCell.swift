//
//  newsTableViewCell.swift
//  TableJSON
//
//  Created by Falgun Patel on 4/2/18.
//  Copyright © 2018 Falgun Patel. All rights reserved.
//

import UIKit

class newsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView?
    @IBOutlet weak var title: UILabel?
    @IBOutlet weak var desc: UILabel?
    @IBOutlet weak var author: UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
