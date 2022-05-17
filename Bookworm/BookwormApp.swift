//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Lucas Chae on 5/17/22.
//

import SwiftUI

@main
struct BookwormApp: App {
    // Most apps work with only one Core Data store at a time, so rather than every view trying to create their own store individually we instead create it once when our app starts, then store it inside the SwiftUI environment.
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
            // Inject it in the environment with managedObjectContext (Live version of our data - write the data into store from memory)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
