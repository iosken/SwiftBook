//
//  CatFactsViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 15.05.2023.
//

import UIKit

class ShowAPIViewController: UICollectionViewController {
    
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
    
    
    
    let userAction = UserAction.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userAction.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatFactsCell", for: indexPath) as? ShowAPICell else { return UICollectionViewCell()}
    
        let userAction = userAction[indexPath.item]
        
        cell.showAPILabel.text = userAction.rawValue
    
        return cell
    }

}

// MARK: UICollectionViewDelegate

extension ShowAPIViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
        
    }
    
}

