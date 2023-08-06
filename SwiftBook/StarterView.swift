//
//  StarterView.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 04.08.2023.
//

import SwiftUI

struct StarterView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "rosette")
                    Text("Main")
                }
            
            HWAward()
                .tabItem {
                    Image(systemName: "star")
                    Text("HW")
                }
            
            CartRacingView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("CartRacing")
                }
            
            AwardsView()
                .tabItem {
                    Image(systemName: "pencil.and.outline")
                    Text("Awards")
                }
        }
    }
}

struct StarterView_Previews: PreviewProvider {
    static var previews: some View {
        StarterView()
    }
}
