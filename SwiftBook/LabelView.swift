//
//  LabelView.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 05.08.2023.
//

import SwiftUI

struct LabelView: View {
    @State private var point = CGPoint(x: 0, y: 0)
    
    var body: some View {
        
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let size = min(width, height)
            
            let step = [
                0,
                size * 0.1,
                size * 0.2,
                size * 0.3,
                size * 0.4,
                size * 0.5,
                size * 0.6,
                size * 0.7,
                size * 0.8,
                size * 0.9,
                size
            ]
            
            var randomStep: CGFloat {
                CGFloat.random(in: 0...size)
            }
            
            var randomScale: CGFloat {
                CGFloat.random(in: 0.05...0.3)
            }
            
            var randomOffset: CGFloat {
                CGFloat.random(in: -size/2 * 0.7...size/2 * 0.7)
            }
            
            Path { path in
                path.move(to: CGPoint(x: step[0], y: 0))
                path.addLine(to: CGPoint(x: step[10], y: 0))
                path.addLine(to: CGPoint(x: step[10], y: step[10]))
                path.addLine(to: CGPoint(x: 0, y: size))
            }
            .fill(Color(red: 0.9, green: 0.9, blue: 0.9))
            
            Path { path in
                path.move(to: CGPoint(x: step[1], y: step[1]))
                path.addLine(to: CGPoint(x: step[9], y: step[1]))
                path.addLine(to: CGPoint(x: step[9], y: step[9]))
                path.addLine(to: CGPoint(x: step[1], y: step[9]))
            }
            .fill(Color(red: 0.4, green: 0.4, blue: 0.4))
            
            Path { path in
                path.move(to: CGPoint(x: step[1], y: step[9]))
                path.addLine(to: CGPoint(x: step[2], y: step[4]))
                path.addLine(to: CGPoint(x: step[3], y: step[8]))
                path.addLine(to: CGPoint(x: step[4], y: step[7]))
                path.addLine(to: CGPoint(x: step[5], y: step[7]))
                path.addLine(to: CGPoint(x: step[6], y: step[8]))
                path.addLine(to: CGPoint(x: step[7], y: step[7]))
                path.addLine(to: CGPoint(x: step[8], y: step[7]))
                path.addLine(to: CGPoint(x: step[9], y: step[9]))
            }
            .fill(Color(red: 0.4, green: 0.7, blue: 0.4))
            
            Path { path in
                path.move(to: CGPoint(x: step[9], y: step[9]))
                path.addLine(to: CGPoint(x: step[8], y: step[7] - 3))
            }
            .stroke(
                Color.yellow,
                style: StrokeStyle(
                    lineWidth: 12,
                    dash: [size / step[8] ]
                )
            )
            
            Path { path in
                path.move(to: CGPoint(x: step[8] + 3, y: step[7]))
                path.addLine(to: CGPoint(x: step[2] - 3, y: step[4]))
            }
            .stroke(
                Color.yellow,
                style: StrokeStyle(
                    lineWidth: 12,
                    dash: [size / step[8]]
                )
            )
            
            Path { path in
                path.move(to: CGPoint(x: step[2], y: step[4] + 2))
                path.addLine(to: CGPoint(x: step[1], y: step[1]))
            }
            .stroke(
                Color.yellow,
                style: StrokeStyle(
                    lineWidth: 12,
                    dash: [size / step[8]]
                )
            )
            
            Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(Color(red: 0.9, green: 0, blue: 0.5))
                .scaleEffect(randomScale)
                .offset(x: randomOffset, y: randomOffset)
                .frame(width: size, height: size)
            
            Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(.orange)
                .scaleEffect(randomScale)
                .offset(x: randomOffset, y: randomOffset)
                .frame(width: size, height: size)
            
            Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(.red)
                .scaleEffect(randomScale)
                .offset(x: randomOffset, y: randomOffset)
                .frame(width: size, height: size)
            
            Text("StarLight")
                .offset(x: 1, y: 1)
                .foregroundColor(.red)
                .fontWeight(.bold)
                
            
//            Text("StarLight2") // why error?
//                .offset(x: 8, y: 8)
//                .foregroundColor(.blue)
        }
    }
}

struct LabelView_Previews: PreviewProvider {
    static var previews: some View {
        LabelView()
            .frame(width: 200, height: 200)
    }
}
