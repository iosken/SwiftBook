//
//  ViewController.swift
//  SwiftBook
//
//  Created by Yuri on 15.12.2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var redCircleView: UIView!
    @IBOutlet var yellowCircleView: UIView!
    @IBOutlet var greenCircleView: UIView!
    
    var counter = 0 // main state cycle counter
    
    override func awakeFromNib() {
        counter += 1
        
        print("\(counter) awakeFromNib isViewLoaded \(isViewLoaded) \n")
        
        sleep(3)
    }
    
    override func loadView() {
        counter += 1
        
        print("\(counter) loadView before super.loadView() isViewLoaded \(isViewLoaded)")
        
        sleep(3)
        
        super.loadView()
        
        print("\(counter) loadView after super.loadView() isViewLoaded \(isViewLoaded) and redCircleView.frame.height is \(redCircleView.frame.height)\n")
        
        sleep(3)
    }
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        counter += 1
        
        print("\(counter) viewDidLoad called \(isViewLoaded) with CircleView.frame.height \(redCircleView.frame.height)\n")
        
        super.viewDidLoad()
        
        sleep(3)
    }
    
    override func viewWillAppear(_ animated: Bool) { // Responding to view-related events
        counter += 1
        
        print("\(counter) viewWillAppear called \(isViewLoaded) with CircleView.frame.height \(redCircleView.frame.height)\n")
        
        sleep(3)
        
        super.viewWillAppear(animated)
        
        sleep(3)
        
        view.layoutIfNeeded()
        
        sleep(3)
    }
    
    override func updateViewConstraints() { // Configuring the view’s layout behavior. Called when the view controller's view needs to update its constraints.
        counter += 1
        
        print("\(counter) updateViewConstraints called with CircleView.frame.height \(redCircleView.frame.height)\n")
        
        sleep(3)
        super.updateViewConstraints() // at final of realization
    }
    
    override func viewWillLayoutSubviews() { // Configuring the view’s layout behavior
        counter += 1
        
        print("\(counter) viewWillLayoutSubviews called with CircleView.frame.height \(redCircleView.frame.height)\n")
        
        sleep(3)
    }
    
    override func viewDidLayoutSubviews() { // Configuring the view’s layout behavior
        counter += 1
        
        print("\(counter) viewDidLayoutSubviews called with CircleView.frame.height \(redCircleView.frame.height)\n")
        
        redCircleView.layer.cornerRadius = redCircleView.frame.width / 2
        yellowCircleView.layer.cornerRadius = yellowCircleView.frame.width / 2
        greenCircleView.layer.cornerRadius = greenCircleView.frame.width / 2
        
        sleep(5)
    }
    
    override func viewDidAppear(_ animated: Bool) { // Responding to view-related events
        counter += 1
        
        print("\(counter) viewDidAppear called with CircleView.frame.height \(redCircleView.frame.height)\n")
        
        super.viewDidAppear(animated)
        
        sleep(3)
    }
    
    override func viewWillDisappear(_ animated: Bool) { // Responding to view-related events
        counter += 1
        
        print("\(counter) viewWillDisappear called with CircleView.frame.height \(redCircleView.frame.height)\n")
        
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) { // Responding to view-related events
        super.viewDidDisappear(animated)
        
        counter += 1
        
        print("\(counter) viewDidDisappear called with CircleView.frame.height \(redCircleView.frame.height)\n")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        counter += 1
        
        print("\(counter) didReceiveMemoryWarning called with CircleView.frame.height \(redCircleView.frame.height)\n")
    }
    
    
}
