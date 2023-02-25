//
//  TrackDetailsViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 25.02.2023.
//

import UIKit

class TrackDetailsViewController: UIViewController {

    @IBOutlet weak var artCoverImageView: UIImageView!
    
    @IBOutlet weak var trackTitleLabel: UILabel!
    
    var track: Track!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        artCoverImageView.image = UIImage(named: track.title)
        
        trackTitleLabel.text = track.title
    }
}
