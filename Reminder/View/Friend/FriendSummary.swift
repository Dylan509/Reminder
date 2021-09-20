//
//  FriendSummary.swift
//  Reminder
//
//  Created by lim jia le on 2021/9/13.
//

import SwiftUI

struct FriendSummary: View {
    
    let person: Person
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(person.name ?? "")
                    .bold()
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                Text("電話： \(person.phoneNo ?? "")")
                Text("生日：") + Text(person.birthday ?? Date(), style: .date)
                
                Divider()
            }
        }
        .padding()
    }
}

struct FriendSummary_Previews: PreviewProvider {
    private static var person: Person {
        let person = Person()
        person.birthday = nil
        person.name = ""
        person.phoneNo = ""
        return person
    }
    static var previews: some View {
        FriendSummary(person: person)
    }
}
