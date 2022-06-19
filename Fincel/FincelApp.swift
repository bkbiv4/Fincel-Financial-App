//
//  FincelApp.swift
//  Fincel
//
//  Created by Bruce Beuzard IV on 6/18/22.
//

import SwiftUI

@main
struct FincelApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
