//
//  ViewController.swift
//  SwiftBook
//
//  Created by Yuri on 15.12.2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet var universalOutlet: UIButton! {
        didSet {
      //      print("\n universalOutlet \(universalOutlet) \n")
            
            //   print("\n universalOutlet \(universalOutlet.titleLabel) \n")
            
            
    //        let intrinsicContentSize = universalOutlet.intrinsicContentSize
        }
            
    }
    
    @IBOutlet var redView: UIView!
    
    
    var counter = 0 // main state cycle counter
    

    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        
        title = "VC"
        showFuncName()
        
        super.viewDidLoad()
        
     //   print("\n universalOutlet \(universalOutlet) \n")
        
        // print("\n universalOutlet \(universalOutlet.titleLabel?.text) \n")
        
        
       // redView.layer.cornerRadius = redView.frame.width / 2

        print("\n SIZE: \(redView.frame.width)")
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) { // Responding to view-related events
        showFuncName()
        
        super.viewWillAppear(animated)
        
       // redView.layer.cornerRadius = redView.frame.width / 2

        print("\n SIZE: \(redView.frame.width)")
        
        // sleep(3)
//        print("\n universalOutlet \(universalOutlet) \n")
        
 //       print("\n universalOutlet \(universalOutlet.titleLabel) \n")
        
        // print("\n universalOutlet.automaticallyUpdatesConfiguration \(universalOutlet.automaticallyUpdatesConfiguration) \n")
        
        
        //view.layoutIfNeeded() ///!!!
        
        
        //sleep(3)
    }
    
    override func updateViewConstraints() { // Configuring the view’s layout behavior. Called when the view controller's view needs to update its constraints.
        showFuncName()
        
        print("\n SIZE: \(redView.frame.width)")
        
  //      print("\n universalOutlet \(universalOutlet) \n")
        
        //   print("\n universalOutlet \(universalOutlet.titleLabel) \n")
        
        super.updateViewConstraints() // at final of realizatio
        
        //view.layoutIfNeeded()
    }
    
    
    override func viewWillLayoutSubviews() { // Configuring the view’s layout behavior
        showFuncName()
        
        super.viewWillLayoutSubviews()
        
        //sleep(3)
        
        

        print("\n SIZE: \(redView.frame.width)")
        
 //       print("\n universalOutlet \(universalOutlet) \n")
        
        //   print("\n universalOutlet \(universalOutlet.titleLabel) \n")
    }
    
    override func viewDidLayoutSubviews() { // Configuring the view’s layout behavior
        showFuncName()
        
        redView.layer.cornerRadius = redView.frame.width / 2
        
        print("\n SIZE: \(redView.frame.width)")
    }
    
    override func viewDidAppear(_ animated: Bool) { //
        super.viewDidAppear(animated)
        
        print("\n SIZE: \(redView.frame.width)")
        
//        print("universalOutlet.configuration?.automaticallyUpdateForSelection \(universalOutlet.configuration?.automaticallyUpdateForSelection)")
        
 //       print("\n universalOutlet \(universalOutlet.titleLabel) \n")
        
        //    print("\n universalOutlet.configuration?.cornerStyle \(universalOutlet) \n")
        
        //   print("\n universalOutlet.configuration?.cornerStyle \(universalOutlet.configuration?.cornerStyle) \n")
        
        //   print("\n universalOutlet.translatesAutoresizingMaskIntoConstraints \(universalOutlet.translatesAutoresizingMaskIntoConstraints) \n")
        
        // print("\n universalOutlet.autoresizesSubviews \(universalOutlet.autoresizesSubviews) \n")
    }
    
    // changes size of view
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        print("\n SIZE: \(redView.frame.width) \n")
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
        
        
    }
    
}

