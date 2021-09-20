//
//  PersonDetail.swift
//  Reminder
//
//  Created by lim jia le on 2021/9/13.
//

import SwiftUI

struct PersonDetail: View {
    @Environment(\.editMode) var editMode
    
    @State var name: String = ""
    @State var birthday: Date = Date()
    @State var phoneNo: String = ""
    
    let person: Person
    
    var body: some View {
        VStack {
            HStack {
                Text("暱稱： ").bold()
                TextField("\(person.name ?? "")", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
            }
            
            HStack {
                Text("電話： ")
                TextField("\(person.phoneNo ?? "")", text: $phoneNo)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            DatePicker(selection: $birthday, displayedComponents: .date) {
                Text("生日:").bold()
            }
        }
        .padding()
        Spacer()
    }
}

struct PersonDetail_Previews: PreviewProvider {
    private static var person: Person {
        let person = Person()
        person.birthday = nil
        person.name = ""
        person.phoneNo = ""
        return person
    }
    
    static var previews: some View {
        PersonDetail(person: person)
    }
}
