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
    var refreshController: UIRefreshControl!
    
    var heros: [Heros] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedData()
        self.refreshController = UIRefreshControl()
        self.refreshController.addTarget(self, action: #selector(feedData), for: .valueChanged)
        self.myCollectionView.addSubview(self.refreshController)
    }
    @objc func feedData() {
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
                    self.activityIndicator.stopAnimating()
                    self.refreshController.endRefreshing()
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
            let defaultLink = "https://api.opendota.com"
            cell.heroImage.downloadedFrom(link: defaultLink + heros[indexPath.row].img)
            cell.heroImage.layer.cornerRadius = cell.heroImage.frame.height / 2
            cell.heroImage.clipsToBounds = true
            cell.heroImage.contentMode = .scaleAspectFill
            return cell
        }
        return UICollectionViewCell()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

