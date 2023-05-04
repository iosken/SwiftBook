//
//  Extension + UIButton.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 03.05.2023.
//

import Foundation
import UIKit

extension UIButton {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.fromValue = 0.95 // стартовый размер
        pulse.toValue = 1 // 100% конечный размер
        pulse.duration = 0.6 // время анимации
        pulse.autoreverses = true // маятник в другую сторону на основе старта-окончания
        pulse.repeatCount = 2 // количество повторений
        pulse.initialVelocity = 0.5 // начальное ускорение
        pulse.damping = 1 // время остановки анимации
        
        layer.add(pulse, forKey:  nil)
    }
}
