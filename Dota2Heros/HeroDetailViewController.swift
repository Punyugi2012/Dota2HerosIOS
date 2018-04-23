//
//  HeroDetailViewController.swift
//  Dota2Heros
//
//  Created by punyawee  on 23/4/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit

class HeroDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   

    var hero: Hero!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeroImage") as! HeroImageTableViewCell
            cell.imageHero.layer.cornerRadius = 3
            cell.imageHero.clipsToBounds = true
            if self.hero.heroImage != nil  {
                cell.imageHero.image = self.hero.heroImage
            }
            else {
                cell.imageHero.image = UIImage(named: "Background")
            }
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PrimaryAttr") as! PriAttrTableViewCell
            cell.primaryAttrLabel.text = hero?.primary_attr
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttackType") as! AttackTypeTableViewCell
        cell.attackTypeLabel.text = hero?.attack_type
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 220
        }
        return 70
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
