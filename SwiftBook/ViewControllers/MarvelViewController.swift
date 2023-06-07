//
//  MarvelViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 06.06.2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class MarvelViewController: UICollectionViewController {
    
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "marvel", for: indexPath) as? MarvelViewCell else { return UICollectionViewCell() }
        let superhero = superheroes[indexPath.row]
        cell.configure(with: superhero)
        return cell
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
