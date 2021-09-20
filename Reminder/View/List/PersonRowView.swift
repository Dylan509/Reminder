//
//  PersonRowView.swift
//  Reminder
//
//  Created by lim jia le on 2021/9/13.
//

import SwiftUI

struct PersonRowView: View {
    let person: Person
    
    var body: some View {
        HStack {
            Text(person.name ?? "")
                .font(.custom("Georgia", size: 20))
                .cornerRadius(5)
        }
    }
}

struct PersonRowView_Previews: PreviewProvider {
    private static var person: Person {
        let person = Person()
        person.birthday = Date()
        person.name = ""
        person.phoneNo = ""
        return person
    }
    
    static var previews: some View {
        PersonRowView(person: person)
    }
}
