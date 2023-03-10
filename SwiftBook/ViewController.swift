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
    
//    @IBOutlet var showButtonOutlet: UIButton! {
//        didSet {
//            print(showButtonOutlet.currentTitle ?? "\n Init showButtonOutlet: UIButton! \n")
//        }
//    }
    
    var counter = 0 // main state cycle counter
    
//    override func awakeFromNib() {
//        showFuncName()
//
//        print("\(title ?? ""): \(counter) (isViewLoaded: \(isViewLoaded)) \n")
//    }
    
//    override func loadView() { // If you use Interface Builder to create your views and initialize the view controller, you must not override this method.
//        showFuncName()
//
//        print("\(title ?? ""): \(counter) loadView before super.loadView() (isViewLoaded: \(isViewLoaded)) and redCircleView.frame.height is \(redCircleView?.frame.height ?? 0)\n")
//
//        print("\(title ?? ""): \(counter) calling super.loadView()...")
//
//        super.loadView()
//
//        print("\(title ?? ""): \(counter) loadView after super.loadView() (isViewLoaded: \(isViewLoaded)) and redCircleView.frame.height is \(redCircleView.frame.height)\n")
//
//        //sleep(3)
//    }
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        
        title = "VC"
        showFuncName()
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) { // Responding to view-related events
        showFuncName()
        
        super.viewWillAppear(animated)
        
        // sleep(3)
        
        //view.layoutIfNeeded()
        
        //sleep(3)
    }
    
    override func updateViewConstraints() { // Configuring the view’s layout behavior. Called when the view controller's view needs to update its constraints.
        showFuncName()
        
        super.updateViewConstraints() // at final of realizatio
    }
    
    override func viewWillLayoutSubviews() { // Configuring the view’s layout behavior
        showFuncName()
    }
    
    override func viewDidLayoutSubviews() { // Configuring the view’s layout behavior
        showFuncName()
        
//        redCircleView.layer.cornerRadius = redCircleView.frame.width / 2
//        yellowCircleView.layer.cornerRadius = yellowCircleView.frame.width / 2
//        greenCircleView.layer.cornerRadius = greenCircleView.frame.width / 2
    }
    
    override func viewDidAppear(_ animated: Bool) { // Responding to view-related events
        showFuncName()

        super.viewDidAppear(animated)
        
        //print("!!! translatesAutoresizingMaskIntoConstraints \(showButtonOutlet.translatesAutoresizingMaskIntoConstraints)")
        
        //view.layoutIfNeeded()
        
        print(view.translatesAutoresizingMaskIntoConstraints)
    }
    
    // changes size of view
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        print("View height: \(size.height), view height: \(size.width)")
    }
    
    override func viewWillDisappear(_ animated: Bool) { // Responding to view-related events
        showFuncName()
        
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) { // Responding to view-related events
        showFuncName()
        
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        showFuncName()
        
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("\n Deinit called \n")
    }
    
    
}

extension ViewController {
    func showFuncName(of function: String = #function) {
        
        counter += 1
        
        print("\(counter) \(function) \(view.frame.size) \n") //(CircleView.frame.height: \(redCircleView?.frame.height ?? 0)) \(title ?? "")
        
        //sleep(3)
    }

}

/* results:

 ------- Clear:
 5 viewDidAppear(_:) (CircleView.frame.height: 0.0) VC

 true

  SCENE: sceneDidBecomeActive(_:)
 -----
 
 ----- Button:
 6 viewDidAppear(_:) (CircleView.frame.height: 0.0) VC

 true

  SCENE: sceneDidBecomeActive(_:)
 
 View height: 430.0, view height: 932.0
 6 viewWillLayoutSubviews() (CircleView.frame.height: 0.0) VC

 7 viewDidLayoutSubviews() (CircleView.frame.height: 0.0) VC

 8 viewWillLayoutSubviews() (CircleView.frame.height: 0.0) VC

 9 viewDidLayoutSubviews() (CircleView.frame.height: 0.0) VC
 
 View height: 430.0, view height: 932.0
 7 viewWillLayoutSubviews() (CircleView.frame.height: 0.0) VC

 8 viewDidLayoutSubviews() (CircleView.frame.height: 0.0) VC
 -----
*/
