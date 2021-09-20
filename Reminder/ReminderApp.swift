//
//  ReminderApp.swift
//  Reminder
//
//  Created by lim jia le on 2021/9/13.
//

import SwiftUI

@main
struct ReminderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            .accentColor(.primary)
        }
    }
}
