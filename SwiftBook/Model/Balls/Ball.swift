//
//  Ball.swift
//  SwiftBook
//
//  Created by Yuri on 19.01.2023.
//

import UIKit

protocol BallProtocol {
    init(color: UIColor, radius: Int, coordinates: (x: Int, y: Int))
}

public class Ball: UIView, BallProtocol {
    required public init(color: UIColor, radius: Int, coordinates: (x: Int, y: Int)) {
        super.init(
            frame: CGRect(
                x: coordinates.x,
                y: coordinates.y,
                width: radius * 2,
                height: radius * 2
            )
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

