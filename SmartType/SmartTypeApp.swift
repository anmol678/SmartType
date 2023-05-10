//
//  SmartTypeApp.swift
//  SmartType
//
//  Created by Anmol Jain on 5/9/23.
//

import SwiftUI

@main
struct SmartTypeApp: App {
    let persistenceController = PersistenceController.shared
    let dataManager = DataManager(persistenceController: PersistenceController.shared)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(dataManager)
        }
    }
}
