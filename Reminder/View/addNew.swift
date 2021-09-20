//
//  addNew.swift
//  Reminder
//
//  Created by lim jia le on 2021/9/13.
//

import SwiftUI
import CoreData

struct addNew: View {
  //  @ObservedObject var notificationManager: NotificationManager
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var addMode
    
    @State var name: String = ""
    @State var birthday: Date = Date()
    @State var phoneNo: String = ""
    
    @State var isFailed = false
    
    var body: some View {
        
        VStack(spacing: 16) {
            HStack {
                Text("暱稱:")
                TextField("請輸入他/她的暱稱", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack {
                Text("電話:")
                TextField("請輸入他/她的電話", text: $phoneNo)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            DatePicker(selection: $birthday, displayedComponents: .date) {
                Text("生日:")
            }
            
            Button(action: {
                let isSuccessful = self.addPerson()
                self.isFailed = !isSuccessful
                if isSuccessful {
                    self.addMode.wrappedValue.dismiss()
                    NotificationManager().createLocalNotification(title: "隨便亂寫的啦", birthday: birthday) { error in
                        if error == nil {
                            DispatchQueue.main.async {
                            //    self.isFailed = false
                            }
                        }
                        
                    }
                }
            }, label: { Text("添加")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
            })
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(15)
            .alert(isPresented: $isFailed) {
                Alert(title: Text("輸入錯誤"), dismissButton: .default(Text("OK")))
            }
            Spacer()
        }
        .navigationTitle("新增名單")
        .padding()
    }
    
    private func addPerson() -> Bool {
        withAnimation {
            guard !name.isEmpty else {
                return false
            }
            
            let person = Person(context: context)
            person.birthday = birthday
            person.name = name
            person.phoneNo = phoneNo
            
            do {
                try context.save()
                print("success")
                return true
            } catch {
                print("error here: \(error)")
                return false
            }
        }
    }
}

struct addNew_Previews: PreviewProvider {
    static var previews: some View {
        addNew()
    }
}
