//
//  GlobalExtensions.swift
//  SwiftBook
//
//  Created by Yuri on 25.01.2023.
//

import Foundation
import UIKit

extension UIViewController {
    static func gradientLayer(bounds: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [#colorLiteral(red: 1, green: 0.9042130062, blue: 0.8607816224, alpha: 1).cgColor, #colorLiteral(red: 0.9233794142, green: 1, blue: 0.8758689237, alpha: 1).cgColor, #colorLiteral(red: 0.8862585912, green: 0.9864693626, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.9574609403, green: 0.9686274529, blue: 0.541431185, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 0.25, 0.93, 1]
        gradientLayer.frame = bounds
        
        return gradientLayer
    }
}

