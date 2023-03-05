//
//  AsyncDemoApp.swift
//  AsyncDemo
//
//  Created by Jonni Akesson on 2023-03-05.
//

import SwiftUI

@main
struct AsyncDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            PhotosListView()
                .environmentObject(PhotosListViewModel())
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
