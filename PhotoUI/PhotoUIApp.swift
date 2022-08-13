//
//  PhotoUIApp.swift
//  PhotoUI
//
//  Created by Алексей Свидницкий on 12.08.2022.
//

import SwiftUI

@main
struct PhotoUIApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
