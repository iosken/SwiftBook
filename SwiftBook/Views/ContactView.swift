//
//  ContactView.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 02.08.2023.
//

import SwiftUI

struct ContactView: View {
    private let size = (UIScreen.main.bounds).size.width / 3
    
    let contact: Person
    
    var body: some View {
        NavigationStack{
            VStack{
                List(["image", "phone", "mail"], id: \.self) { line in
                    switch line {
                    case "image":
                        HStack {
                            Spacer()
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: size, height: size)
                                .padding(size / 3)
                            Spacer()
                        }
                    case "phone":
                        HStack {
                            Image(systemName: "phone")
                            Text("\(contact.phone)")
                            Spacer()
                        }
                    default:
                        HStack {
                            Image(systemName: "envelope")
                            Text(contact.email)
                            Spacer()
                        }
                    }
                }
                .navigationBarTitle("\(contact.name) \(contact.surname)")
                .navigationBarTitleDisplayMode(.inline)
                Spacer()
            }
        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView(contact: Person.newPerson())
    }
}
