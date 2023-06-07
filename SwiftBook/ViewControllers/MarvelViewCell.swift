//
//  MarvelCollectionViewCell.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 06.06.2023.
//

import UIKit

class MarvelViewCell: UICollectionViewCell {
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 15
        }
    }
    
    private var activityIndicator: UIActivityIndicatorView?
//    private var imageURL: URL? { // Image load optimization 1
//        didSet {
//            imageView.image = nil
//            updateImage()
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        activityIndicator = showSpinner(in: imageView)
    }
    
    func configure(with superhero: Superhero) {
        mainLabel.text = superhero.name
        guard let imageURL = URL(string: superhero.images.lg) else { return }
        NetworkManager.shared.fetchData(fromData: imageURL) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.imageView.image = UIImage(data: imageData)
                self?.activityIndicator?.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    private func updateImage() {
//        guard let imageURL = imageURL else { return }
//    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .systemRed
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
}
