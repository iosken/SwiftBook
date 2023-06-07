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
    private var imageURL: URL? { // Image load optimization 1
        didSet {
            imageView.image = nil
            updateImage()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        activityIndicator = showSpinner(in: imageView)
    }
    
    func configure(with superhero: Superhero) {
        mainLabel.text = superhero.name
        imageURL = URL(string: superhero.images.lg)

    }
    
    private func updateImage() {
        guard let imageURL = imageURL else { return }
        
        getImage(from: imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                if imageURL == self?.imageURL {
                    self?.imageView.image = image
                    self?.activityIndicator?.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }

    }
    
    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        // Get image from cache

        if let cachedImage = ImageCacheManager.shared.object(forKey: url.lastPathComponent as NSString) {
            print("Image from cache: ", url.lastPathComponent)
            completion(.success(cachedImage))
            return
        }

        // Download image from url
        NetworkManager.shared.fetchData(fromData: url) { result in // moved from configure(with superhero: Superhero)
            switch result {
            case .success(let imageData):
                guard let uiImage = UIImage(data: imageData) else { return }
                ImageCacheManager.shared.setObject(uiImage, forKey: url.lastPathComponent as NSString)
                print("Image from network: ", url.lastPathComponent)
                completion(.success(uiImage))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
    
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
