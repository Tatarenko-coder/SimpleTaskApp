//
//  SimpleTaskAppApp.swift
//  SimpleTaskApp
//
//  Created by TD on 04.03.2024.
//

import SwiftUI

@main
struct SimpleTaskAppApp: App {
    let persistenceController = CoreDateManager.shared.persistentContainer

    var body: some Scene {
        WindowGroup {
            FinalView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }
    }
}
