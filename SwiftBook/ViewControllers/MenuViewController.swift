//
//  MenuViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 19.05.2023.
//

import UIKit

enum UserAction: String, CaseIterable {
    case emojihub = "Emogy Hub"
    case Genderize = "Genderize"
    case swap = "SWAP"
    case wallstreetbet = "Wall Street Bet"
}

class MenuViewController: UICollectionViewController {
    
    let userActions = UserAction.allCases

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MenuCell else { return UICollectionViewCell()}
        
        let links = Link.allCases
        
        cell.contentNameLabel.text = userActions[indexPath.row].rawValue
        cell.linkLabel.text = links[indexPath.row].rawValue
        cell.contentImageView.image = UIImage(named: "content")
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    
}

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}
