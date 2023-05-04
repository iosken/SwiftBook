//
//  ViewController.swift
//  SwiftBook
//
//  Created by Yuri on 15.12.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var coreAnimationView: UIView!
    
    private var animationStarted = false

    @IBAction func startCoreAnimation(_ sender: UIButton) {
        sender.pulsate()
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: [.autoreverse, .repeat]) { [unowned self] in
                if !animationStarted {
                    coreAnimationView.frame.origin.x -= 40
                    animationStarted.toggle()
                }
            
        }
    }
    
}

