//
//  friendList.swift
//  Reminder
//
//  Created by lim jia le on 2021/9/13.
//

import SwiftUI

struct friendList: View {
    @StateObject private var notificationManager = NotificationManager()
    @State private var isCreatePresented = false
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Person.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Person.name, ascending: false)], animation: .default)
    var persons: FetchedResults<Person>
    
    @State private var addNew = false
//    @State private var showingProfile = false
    
    @ViewBuilder
    var infoOverlayView: some View {
        switch notificationManager.authorizationStatus {
        case .authorized:
            if persons.isEmpty {
                InfoOverlayView(
                    infoMessage: "暫時還沒有任何資訊",
                    buttonTitle: "新增",
                    systemImageName: "person.badge.plus",
                    action: {
                        isCreatePresented = true
                    })
            }
        case .denied:
            InfoOverlayView(
                infoMessage: "請允許打開通知",
                buttonTitle: "Settings",
                systemImageName: "gear",
                action: {
                    if let url = URL(string: UIApplication.openSettingsURLString),
                       UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                })
        default:
            EmptyView()
        }
    }
    var body: some View {
        List {
            ForEach(persons) { person in
                NavigationLink(destination: FriendHost(person: person)) {
                    PersonRowView(person: person)
                    Spacer()
                }
            }
            .onDelete(perform: delete)
        }
        .listStyle(InsetGroupedListStyle())
        .overlay(infoOverlayView)
        .navigationBarTitle("Friends")
        .navigationBarItems(trailing: NavigationLink(destination: Reminder.addNew().environment(\.managedObjectContext, context)) {
            Image(systemName: "person.badge.plus")
            })
        .onAppear(perform:
                    notificationManager.reloadAuthorizationStatus)
        .onChange(of: notificationManager.authorizationStatus) { authorizationStatus in
            switch authorizationStatus {
            case .notDetermined:
                notificationManager.requestAuthorization()
            case .authorized:
                notificationManager.reloadLocalNotification()
            default:
                break
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) {
            _ in notificationManager.reloadAuthorizationStatus()
        }
        .sheet(isPresented: $isCreatePresented) {
            NavigationView {
                Reminder.addNew().environment(\.managedObjectContext, context)
            }
            .accentColor(.primary)
        }
    }
    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            context.delete(persons[index])
        }
        
        do {
            try context.save()
        } catch {
            print("delete error: \(error)")
        }
    }
}

struct friendList_Previews: PreviewProvider {
    static var previews: some View {
        friendList()
    }
}
