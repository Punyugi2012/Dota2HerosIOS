//
//  HeroCollectionViewCell.swift
//  Dota2Heros
//
//  Created by punyawee  on 18/4/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit

class HeroCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    func setValue(_ hero: Hero) {
        self.heroName.text = hero.localized_name
        if hero.heroImage != nil {
            self.heroImage.image = hero.heroImage
        }
        else {
            if Reachability.isConnectNetwork() {
                self.setImage(hero)
            }
        }
    }
    func setImage(_ hero: Hero) {
        let defaultLink = "https://api.opendota.com"
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: URL(string: defaultLink + hero.img)!) {
                hero.heroImage = UIImage(data: data)!
                DispatchQueue.main.async {
                    self.heroImage.image = hero.heroImage
                }
            }
        }
    }
}

