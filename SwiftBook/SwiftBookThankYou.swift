//
//  SwiftBookThankYou.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 05.08.2023.
//

import SwiftUI

struct SwiftBookThankYou: View {
    
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
            
            Path { path in
                path.move(to: CGPoint(x: step[0], y: step[0]))
                path.addLine(to: CGPoint(x: step[10], y: step[0]))
                path.addLine(to: CGPoint(x: step[10], y: step[10]))
                path.addLine(to: CGPoint(x: step[0], y: step[10]))
            }
            .fill(Gradient(colors: [
                Color(red: 0.01, green: 0.01, blue: 0.01),
                Color(red: 0.1, green: 0.2, blue: 0)
            ]))
            .cornerRadius(size / 20)
            
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
                path.move(to: CGPoint(x: step[3], y: step[8]))
                path.addLine(to: CGPoint(x: step[8], y: step[7]))
            }
            .stroke(
                Color.yellow,
                style: StrokeStyle(
                    lineWidth: size / 15,
                    dash: [size / step[8]]
                )
            )
            .blur(radius: 1)
            
            Path { path in
                path.move(to: CGPoint(x: step[8], y: step[7] + 4))
                path.addLine(to: CGPoint(x: step[2] - 3, y: step[4]))
            }
            .stroke(
                Color.yellow,
                style: StrokeStyle(
                    lineWidth: size / 15,
                    dash: [size / step[8]]
                )
            )
            .blur(radius: 1)
            
            Path { path in
                path.move(to: CGPoint(x: step[2], y: step[4] + 1))
                path.addLine(to: CGPoint(x: size / 5, y: step[1]))
            }
            .stroke(
                Color.yellow,
                style: StrokeStyle(
                    lineWidth: size / 15,
                    dash: [size / step[8]]
                )
            )
            .blur(radius: 1)
            
            Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(Color(red: 1, green: 1, blue: 0.4))
                .scaleEffect(0.3)
                .offset(x: -step[3], y: -step[1])
                .frame(width: size, height: size)
            
            Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(Color(red: 1, green: 1, blue: 0.5))
                .scaleEffect(0.2)
                .offset(x: step[3] - 6, y: step[2])
                .frame(width: size, height: size)
            
            Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(Color(red: 1, green: 1, blue: 0.6))
                .scaleEffect(0.1)
                .offset(x: -step[2], y: step[3])
                .frame(width: size, height: size)
            
            Text("SwiftBook, Thank You!")
                .offset(x: step[1] / 3, y: step[1] / 8)
                .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                .fontWeight(.bold)
                .blur(radius: 0.1)
                .font(.system(size: size / 14))
            
            Text("iosken")
                .offset(x: step[1], y: step[9])
                .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                .fontWeight(.bold)
                .blur(radius: 0.1)
                .font(.system(size: size / 14))

//            Text("Some text") // why error?
        }
        
    }
    
}

struct LabelView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftBookThankYou()
            .frame(width: 200, height: 200)
    }
}
