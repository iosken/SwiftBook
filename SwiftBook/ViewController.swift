//
//  ViewController.swift
//  SwiftBook
//
//  Created by Yuri on 15.12.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var redCircleView: UIView!
    @IBOutlet var yellowCircleView: UIView!
    @IBOutlet var greenCircleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad:", redCircleView.frame.width / 2)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        redCircleView.layer.cornerRadius = redCircleView.frame.width / 2
        yellowCircleView.layer.cornerRadius = yellowCircleView.frame.width / 2
        greenCircleView.layer.cornerRadius = greenCircleView.frame.width / 2

        print("viewWillLayoutSubviews:", redCircleView.frame.width / 2)
    }

}

