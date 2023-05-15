//
//  CatFactsViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 15.05.2023.
//

import UIKit

class CatFactsViewController: UICollectionViewController {
    
    enum Link: String {
        case catFactsURL = "https://github.com/alexwohlbruck/cat-facts/blob/master/bower.json"
        case SWAPIURL = "https://swapi.dev/api/planets/3/?format=json"
        case WallstreetbetsURL = "https://tradestie.com/api/v1/apps/reddit"
    }
    
    enum UserAction: String, CaseIterable {
        case catFacts = "Fetch CatFacts"
        case SWAPI = "Fetch SWAPI"
        case Wallstreetbets = "Fetch Wallstreetbets"
    }
    
    
    
    var catFacts: CatFacts?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatFactsCell", for: indexPath) as? CatFactsCell else { return UICollectionViewCell()}
    
        // Configure the cell
    
        return cell
    }

}

// MARK: UICollectionViewDelegate

extension CatFactsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
        
    }
    
}

