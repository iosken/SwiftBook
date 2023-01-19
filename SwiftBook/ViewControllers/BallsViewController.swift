//
//  SurpriceViewController.swift
//  SwiftBook
//
//  Created by Yuri on 19.01.2023.
//

import UIKit

class BallsViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        
        let screenHeight = (UIScreen.main.bounds).size.height
        let screenWidth = (UIScreen.main.bounds).size.width
        
        let area = SquareArea(size: CGSize(width: screenWidth, height: screenHeight), color: UIColor.gray)
        
        area.setBalls(withColors: [#colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)], andRadius: 30)
        
        self.view.addSubview(area)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
