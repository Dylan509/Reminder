//
//  FriendHost.swift
//  Reminder
//
//  Created by lim jia le on 2021/9/14.
//

import SwiftUI

struct FriendHost: View {
    @Environment(\.editMode) var editMode
    
    let person: Person
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                if editMode?.wrappedValue == .active {
                    Button("cancel") {
                        editMode?.animation()
                            .wrappedValue = .inactive
                        
                    }
                }
                Spacer()
                .navigationBarItems(trailing: EditButton())
            //    EditButton()
            }
            if editMode?.wrappedValue == .inactive {
                FriendSummary(person: person)
            } else {
                PersonDetail(person: person)
                    .onAppear {
                        
                    }
                    .onDisappear {
                        
                    }
            }
        }
        .padding()
        Spacer()
    }
}

struct FriendHost_Previews: PreviewProvider {
    private static var person: Person {
        let person = Person()
        person.birthday = Date()
        person.name = ""
        person.phoneNo = ""
        return person
    }
    static var previews: some View {
        FriendHost(person: person)
    }
}
