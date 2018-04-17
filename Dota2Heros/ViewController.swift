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

class ViewController: UIViewController {
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
                print(self.heros)
            }
            else {
                print("Found Error")
            }
        }.resume()
    }
}

