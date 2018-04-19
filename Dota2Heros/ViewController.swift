//
//  ViewController.swift
//  Dota2Heros
//
//  Created by punyawee  on 17/4/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit

class Hero:Decodable {
    var localized_name: String
    var img: String
    var heroImage: UIImage?
    private enum CodingKeys: String, CodingKey {case localized_name, img}
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

class ViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var heros: [Hero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedData()
    }
    
    @objc func feedData() {
        if Reachability.isConnectedToNetwork() {
            let url = URL(string: "https://api.opendota.com/api/heroStats")
            URLSession.shared.dataTask(with: url!) { (data, reponse, error) in
                if error == nil {
                    do {
                        self.heros = try JSONDecoder().decode([Hero].self, from: data!)
                    }
                    catch {
                        print("Parse Fail")
                    }
                    DispatchQueue.main.async {
                        self.myCollectionView.reloadData()
                        self.activityIndicator.stopAnimating()
                    }
                }
                else {
                    print("Found Error")
                }
            }.resume()
        }
        else {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: "Connection Network Fail", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: {
                    self.activityIndicator.stopAnimating()
                })
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heros.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCell", for: indexPath) as! HeroCollectionViewCell
        cell.setValue(self.heros[indexPath.row])
        cell.heroImage.layer.cornerRadius = cell.heroImage.frame.height / 2
        cell.heroImage.clipsToBounds = true
        cell.heroImage.contentMode = .scaleAspectFill
        return cell
    }
    
    @IBAction func refresh() {
        self.activityIndicator.startAnimating()
        feedData()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

