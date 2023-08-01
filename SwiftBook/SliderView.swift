//
//  SliderView.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 29.07.2023.
//

import SwiftUI

struct SliderView: UIViewRepresentable {
    @Binding var value: Float
    
    var alpha: Float
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.thumbTintColor = UIColor(red: 255, green: 0, blue: 0, alpha: CGFloat(alpha))
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.touchCancel),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = value
        
        uiView.thumbTintColor = UIColor(red: 255, green: 0, blue: 0, alpha: CGFloat(alpha))
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(value: $value)
    }
}

extension SliderView {
    final class Coordinator: NSObject {
        @Binding var value: Float
        
        init(value: Binding<Float>) {
            self._value = value
        }
        
        @objc func touchCancel(_ sender: UISlider) {
            value = sender.value
        }
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(value: .constant(3.0), alpha: 1.0)
    }
}

