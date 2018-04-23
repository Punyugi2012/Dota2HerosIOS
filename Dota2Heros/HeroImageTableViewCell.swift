//
//  HeroImageTableViewCell.swift
//  Dota2Heros
//
//  Created by punyawee  on 23/4/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit

class HeroImageTableViewCell: UITableViewCell {

    @IBOutlet weak var imageHero: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
