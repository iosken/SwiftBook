//
//  SuperHeroesViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 05.06.2023.
//

import UIKit
import Kingfisher

final class SuperHeroesViewController: UICollectionViewController {
    
    private var superheroes: [Superhero] = []
    private let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        superheroes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "superhero", for: indexPath) as! SuperHeroViewCell
        let superhero = superheroes[indexPath.row]
        cell.configure(with: superhero)
        return cell
    }
    
    @IBAction func clearCache(_ sender: UIBarButtonItem) {
        let cache = ImageCache.default
        cache.clearMemoryCache()
        cache.clearDiskCache() {
            print("Done")
        }
    }
    
    func fetch() {
        networkManager.fetchData(type: Superhero.self, fromJson: Link.heroes.url) { result in
            switch result {
            case .success(let data):
                self.superheroes = data
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
