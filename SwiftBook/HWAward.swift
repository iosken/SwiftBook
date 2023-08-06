//
//  HWAward.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 06.08.2023.
//

import SwiftUI

struct HWAward: View {
    @State private var awardIsShowing = false
    @State private var offset: CGFloat = 500
    
    private let size = (UIScreen.main.bounds).size.width / 1.4
    
    var body: some View {
        VStack {
            Button(action: buttonAction) {
                Text(awardIsShowing ? "Hide Award" : "Show Award")
                Spacer()
                Image(systemName: "chevron.up.square")
                    .scaleEffect(awardIsShowing ? 2 : 1)
                    .rotationEffect(.degrees(awardIsShowing ? 0 : 180))
            }
            
            Spacer()
            if awardIsShowing {
                SwiftBookThankYou()
                    .frame(width: size, height: size)
                    .offset(x: offset, y: 0)
                    .transition(.starMove)
                    .onAppear {
                        offset = 0
                    }
            }
            
            
            Spacer()
        }
        .font(.headline)
        .padding()
    }
    
    private func buttonAction() {
        withAnimation(.spring(
            response: 0.55,
            dampingFraction: 0.25,
            blendDuration: 0
        )) {
            awardIsShowing.toggle()
        }
    }
}



struct HWAward_Previews: PreviewProvider {
    static var previews: some View {
        HWAward()
    }
}

extension AnyTransition {
    
    static var starMove: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading)
            .combined(with: .slide)
        
        let removal = AnyTransition.move(edge: .leading)
            .combined(with: .scale)
        
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
}
