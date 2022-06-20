//
//  FincelApp.swift
//  Fincel
//
//  Created by Bruce Beuzard IV on 6/18/22.
//

import SwiftUI

@main
struct FincelApp: App {
    let persistenceController = CoreDataManager.shared

    var body: some Scene {
        WindowGroup {
            CreateAccountView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
