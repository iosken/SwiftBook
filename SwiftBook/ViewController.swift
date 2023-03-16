//
//  ViewController.swift
//  SwiftBook
//
//  Created by Yuri on 15.12.2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - IBOutlets
//    @IBOutlet var redCircleView: UIView!
//    @IBOutlet var yellowCircleView: UIView!
//    @IBOutlet var greenCircleView: UIView!
    
    @IBOutlet var universalOutlet: UIButton!
    
    //@IBOutlet var universalOutlet: UILabel!
    
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
 
//        Tinted to default:
//        universalOutlet.configuration?.automaticallyUpdateForSelection = false
//        universalOutlet.configuration?.contentInsets = .zero
//        universalOutlet.configuration?.imagePlacement = .all
//        universalOutlet.configuration?.titleAlignment = .center
        
        //universalOutlet.configuration = nil
//
//
//        universalOutlet.titleLabel?.layer.position = (defaultButton.titleLabel?.layer.position)!
//
//        universalOutlet.titleLabel?.text = "To DEFAULT Button"
//
//        universalOutlet.titleLabel?.isHidden = false
//
//        universalOutlet.titleLabel?.bounds = (defaultButton.titleLabel?.bounds)!
//        universalOutlet.titleLabel?.accessibilityElementsHidden = false
//
//        universalOutlet.titleLabel?.layer.isHidden = false
//
//        universalOutlet.titleLabel?.isHidden = false
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) { // Responding to view-related events
        showFuncName()
        
        super.viewWillAppear(animated)
        
        // sleep(3)
        
        //view.layoutIfNeeded() ///!!!
        
        //sleep(3)
    }
    
    override func updateViewConstraints() { // Configuring the view’s layout behavior. Called when the view controller's view needs to update its constraints.
        showFuncName()
        
        super.updateViewConstraints() // at final of realizatio
    }
    
    override func viewWillLayoutSubviews() { // Configuring the view’s layout behavior
        showFuncName()
        
        super.viewWillLayoutSubviews()
        
        print(universalOutlet.constraints)
    }
    
    override func viewDidLayoutSubviews() { // Configuring the view’s layout behavior
        showFuncName()
        
//        redCircleView.layer.cornerRadius = redCircleView.frame.width / 2
//        yellowCircleView.layer.cornerRadius = yellowCircleView.frame.width / 2
//        greenCircleView.layer.cornerRadius = greenCircleView.frame.width / 2
    }
    
    override func viewDidAppear(_ animated: Bool) { // Responding to view-related events
        showFuncName()
        
        //universalOutlet.titleLabel?.isHidden = false

        //print("\n", universalOutlet.configuration, "\n")
        
        //print("\n", universalOutlet.titleLabel?.layer, "\n")
        
        //universalOutlet.directionalLayoutMargins.top = 120
        //universalOutlet.preservesSuperviewLayoutMargins = true
        
        print("\n universalOutlet.preservesSuperviewLayoutMargins ", universalOutlet.preservesSuperviewLayoutMargins, "\n")
        print("\n universalOutlet.directionalLayoutMargins", universalOutlet.directionalLayoutMargins, "\n")
        
        print("\n view.translatesAutoresizingMaskIntoConstraints", view.translatesAutoresizingMaskIntoConstraints, "\n")
        
        print("\n universalOutlet.translatesAutoresizingMaskIntoConstraints", universalOutlet.translatesAutoresizingMaskIntoConstraints, "\n")
        
       // print("\n universalOutlet.translatesAutoresizingMaskIntoConstraints", view.safeAreaInsets.translatesAutoresizingMaskIntoConstraints, "\n")
        
        
        //print("\n view.preservesSuperviewLayoutMargins ", view.preservesSuperviewLayoutMargins, "\n")
        
        let intrinsicContentSize = universalOutlet.intrinsicContentSize

        if intrinsicContentSize.width > 0 && intrinsicContentSize.height > 0 {
            print("Button has an intrinsic content size \(intrinsicContentSize.width) \(intrinsicContentSize.height)")
        } else {
            print("Button does not have an intrinsic content size")
        }

        super.viewDidAppear(animated)
        
        //print("!!! translatesAutoresizingMaskIntoConstraints \(showButtonOutlet.translatesAutoresizingMaskIntoConstraints)")
        
        //view.layoutIfNeeded()
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
    
    @IBAction func changerButton(_ sender: Any) {
        universalOutlet.setImage(UIImage(named: "imagesButtons"), for: .normal)
    }
    
    @IBAction func changerSecondButton(_ sender: Any) {
        universalOutlet.setImage(UIImage(named: "imageToButton"), for: .normal)
    }
    
    @IBAction func mainButton(_ sender: Any) {
        universalOutlet.setImage(UIImage(named: "pencil"), for: .normal)
    }
    
}

extension ViewController {
    func showFuncName(of function: String = #function) {
        
        counter += 1
        
        print("\(counter) \(function) \(view.frame.size) \n") //(CircleView.frame.height: \(redCircleView?.frame.height ?? 0)) \(title ?? "")
        
        //sleep(3)
    }

}

