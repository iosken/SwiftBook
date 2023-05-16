//
//  CatFactsViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 15.05.2023.
//

import UIKit

final class ShowAPIViewController: UICollectionViewController {
    
    private enum Link: String {
        case catFactsURL = "https://github.com/alexwohlbruck/cat-facts/blob/master/bower.json"
        case sWAPIURL = "https://swapi.dev/api/planets/3/?format=json"
        case wallstreetbetsURL = "https://tradestie.com/api/v1/apps/reddit"
        case genderize = "https://api.genderize.io/?name=scott"
    }
    
    private enum UserAction: String, CaseIterable {
        case catFacts = "Fetch CatFacts"
        case sWAPI = "Fetch SWAPI"
        case wallstreetbets = "Fetch Wallstreetbets"
        case genderize = "Fetch Genderize"
    }
    
    private let userAction = UserAction.allCases
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userAction.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CatFactsCell",
            for: indexPath) as? ShowAPICell else { return UICollectionViewCell()}
        
        let userAction = userAction[indexPath.item]
        cell.showAPILabel.text = userAction.rawValue
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userAction[indexPath.row]
        
        switch userAction {
        case .catFacts: fetchCatFacts()
        case .sWAPI: fetchSWAPI()
        case .wallstreetbets: fetchWallstreetbets()
        case .genderize: fetchGenderize()
        }
    }
    
    // MARK: - Private Methods
    private func successAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Success",
                message: "You can see the results in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func unsuccessAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Failed",
                message: "You can see error in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}

// MARK: UICollectionViewDelegate

extension ShowAPIViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
        
    }
    
}

// MARK: Extension Fetch Methods

extension ShowAPIViewController {
    
    private func fetchCatFacts() {
        guard let url = URL(string: Link.catFactsURL.rawValue) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let catFacts = try jsonDecoder.decode(CatFacts.self, from: data)
                print(catFacts)
                self?.successAlert()
            } catch {
                print(error.localizedDescription)
                self?.unsuccessAlert()
            }
        }
        
        task.resume()
    }
    
    private func fetchSWAPI() {
        guard let url = URL(string: Link.sWAPIURL.rawValue) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No descruption")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let sWAPI = try jsonDecoder.decode(SWAPI.self, from: data)
                print(sWAPI)
                self?.successAlert()
            } catch {
                print(error.localizedDescription)
                self?.unsuccessAlert()
            }
        }
        
        task.resume()
    }
    
    private func fetchWallstreetbets() {
        guard let url = URL(string: Link.wallstreetbetsURL.rawValue) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No descriptions")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let wallstreetbets = try jsonDecoder.decode(
                    [Wallstreetbet].self, from: data
                )
                print(wallstreetbets)
                self?.successAlert()
            } catch {
                print(error.localizedDescription)
                self?.unsuccessAlert()
            }
        }
        
        task.resume()
    }
    
    private func fetchGenderize() {
        guard let url = URL(string: Link.genderize.rawValue) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No description")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let genderize = try jsonDecoder.decode(
                    Genderize.self,
                    from: data
                )
                print(genderize)
                self?.successAlert()
            } catch {
                self?.unsuccessAlert()
            }
        }
        
        task.resume()
    }
    
}

