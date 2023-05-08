//
//  AnimationsRandomizerViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 05.05.2023.
//

import UIKit
import SpringAnimation

class AnimationsRandomizerViewController: UIViewController {
    
    @IBOutlet var presetLabel: UILabel!
    @IBOutlet var curveLabel: UILabel!
    @IBOutlet var forceLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var delayLabel: UILabel!
    
    @IBOutlet var targetAnimationView: SpringView!
    
    lazy var nextAnimation = randomPreset()
    
    var firstRun = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animate()
    }

    @IBAction func runPressed(_ sender: UIButton) {
        animate(sender: sender)
    }
}

extension AnimationsRandomizerViewController {
    
    func animate(sender: UIButton? = nil) {
        
        targetAnimationView.animation = nextAnimation.animation
        targetAnimationView.curve = nextAnimation.curve
        targetAnimationView.force = nextAnimation.force
        targetAnimationView.duration = nextAnimation.duration
        targetAnimationView.delay = nextAnimation.delay
        
        presetLabel.text = "preset: " + targetAnimationView.animation
        curveLabel.text = "curve: " + targetAnimationView.curve
        forceLabel.text = "force: " + targetAnimationView.force.formatted()
        durationLabel.text = "duration: " + targetAnimationView.duration.formatted()
        delayLabel.text = "delay: " + targetAnimationView.delay.formatted()
        
        if firstRun {
            firstRun.toggle()
        } else {
            targetAnimationView.animate()
            nextAnimation = randomPreset()
            sender?.setTitle(nextAnimation.animation, for: .normal)
        }
    }
    
    func randomPreset() -> (animation: String, curve: String, force: CGFloat, duration: CGFloat, delay: CGFloat) {
        let animations = ["pop", "slideLeft", "slideRight", "slideDown", "slideUp", "squeezeLeft", "squeezeRight", "squeezeDown", "squeezeUp", "fadeIn", "fadeOut", "fadeOutIn", "fadeInLeft", "fadeInRight", "fadeInDown", "fadeInUp", "zoomIn", "zoomOut", "fall", "shake", "flipX", "flipY", "morph", "squeeze", "flash", "wobble", "swing"]
        
        let curves = ["easeIn", "easeOut", "easeInOut", "linear", "spring", "easeInSine", "easeOutSine", "easeInOutSine", "easeInQuad", "easeOutQuad", "easeInOutQuad", "easeInCubic", "easeOutCubic", "easeInOutCubic", "easeInQuart", "easeOutQuart", "easeInOutQuart", "easeInQuint", "easeOutQuint", "easeInOutQuint", "easeInExpo", "easeOutExpo", "easeInOutExpo", "easeInCirc", "easeOutCirc", "easeInOutCirc", "easeInBack", "easeOutBack", "easeInOutBack"]
        
        var force: CGFloat {
            CGFloat.random(in: 1...5)
        }
        
        var duration: CGFloat {
            CGFloat.random(in: 0.5...5)
        }
        
        var delay: CGFloat {
            CGFloat.random(in: 0...2)
        }
        
        return (animation: animations.randomElement() ?? "", curve: curves.randomElement() ?? "", force: force, duration: duration, delay: delay)
    }
}


