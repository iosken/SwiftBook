//
//  ContactView.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 02.08.2023.
//

import SwiftUI

struct ContactView: View {
    var body: some View {
        NavigationStack{
            VStack{
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .padding(50)
                Spacer()
            }
            .navigationTitle("Person")
        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
