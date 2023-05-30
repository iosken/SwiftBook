//
//  AnimationManager.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 30.05.2023.
//

import Foundation

import SpringAnimation

final class AnimationManager {
    static let share = AnimationManager()
    
    private init() {}
    
    func animate(sender: Springable) {
        
        let nextAnimation = randomPreset()
        
        sender.animation = nextAnimation.animation
        sender.curve = nextAnimation.curve
        sender.force = nextAnimation.force
        sender.duration = nextAnimation.duration
        sender.delay = nextAnimation.delay
        sender.animate()
        
    }
    
    func randomPreset() -> (animation: String, curve: String, force: CGFloat, duration: CGFloat, delay: CGFloat) {
        var animations: [AnimationPreset] = [] {
            didSet {
                if let fadeOutIndex = AnimationPreset.allCases.firstIndex(of: AnimationPreset.fadeOut) {
                    animations.remove(at: fadeOutIndex)
                }
                if let zoomOutIndex = AnimationPreset.allCases.firstIndex(of: AnimationPreset.zoomOut) {
                    animations.remove(at: zoomOutIndex)
                }
                
                if let fallIndex = AnimationPreset.allCases.firstIndex(of: AnimationPreset.fall) {
                    animations.remove(at: fallIndex)
                }
            }
        }
        
        animations = AnimationPreset.allCases
        
        let curves = AnimationCurve.allCases
        
        var force: CGFloat {
            CGFloat.random(in: 1...2)
        }
        
        var duration: CGFloat {
            CGFloat.random(in: 0.5...2)
        }
        
        var delay: CGFloat {
            CGFloat.random(in: 0...1)
        }
        
        return (animation: animations.randomElement()?.rawValue ?? "", curve: curves.randomElement()?.rawValue ?? "", force: force, duration: duration, delay: delay)
    }
    
}
