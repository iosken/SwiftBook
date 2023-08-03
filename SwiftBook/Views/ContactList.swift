//
//  ContactList.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 02.08.2023.
//

import SwiftUI

struct ContactList: View {
    let isDetailed: Bool
    
    let contacts: [Person]
    
    var body: some View {
        if isDetailed {
            List(contacts) { contact in
                Section(header: Text(contact.name)) {
                    ForEach(["phone", "mail"], id: \.self) { line in
                        if line == "phone" {
                            HStack {
                                Image(systemName: "phone")
                                Text("\(contact.phone)")
                                Spacer()
                            }
                        } else {
                            HStack {
                                Image(systemName: "envelope")
                                Text(contact.email)
                                Spacer()
                            }
                        }
                    }
                    
                    
                }
            }
            //.navigationTitle("Contact List")
            //.listStyle(.plain)


        } else {
            List(contacts) { contact in
                Text("\(contact.name) \(contact.surname)")
            }
            .navigationTitle("Contact List")
            .listStyle(.plain)
        }

    }
}

struct ContactList_Previews: PreviewProvider {
    static var previews: some View {
        ContactList(isDetailed: true, contacts: [Person(
            id: UUID(),
            name: "sdfsdf",
            surname: "sdfsdf",
            email: "sdfdsf@kglfdkjg",
            phone: "453543534")])
    }
}
