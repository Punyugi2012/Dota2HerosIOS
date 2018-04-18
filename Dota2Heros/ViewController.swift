//
//  ViewController.swift
//  Dota2Heros
//
//  Created by punyawee  on 17/4/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit

struct Heros:Decodable {
    var localized_name: String
    var img: String
}

class ViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var myCollectionView: UICollectionView!
    var heros: [Heros] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        URLSession.shared.dataTask(with: url!) { (data, reponse, error) in
            if error == nil {
                do {
                    self.heros = try JSONDecoder().decode([Heros].self, from: data!)
                }
                catch {
                    print("Parse Fail")
                }
                DispatchQueue.main.async {
                    self.myCollectionView.reloadData()
                }
            }
            else {
                print("Found Error")
            }
        }.resume()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heros.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCell", for: indexPath) as? HeroCollectionViewCell {
            cell.heroName.text = heros[indexPath.row].localized_name
            cell.heroImage.image = UIImage(named: "background")
            return cell
        }
        return UICollectionViewCell()
    }
    
}

