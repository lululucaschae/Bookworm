//
//  DataController.swift
//  Bookworm
//
//  Created by Lucas Chae on 5/17/22.
//
import CoreData
import Foundation

class DataController: ObservableObject {
    // Tell Core Data we want to use the Bookworm data model. (ONLY data model for this line)
    let container = NSPersistentContainer(name: "Bookworm")
    
    // Initializer for DataController that loads our stored data immediately
    init() {

        container.loadPersistentStores { description, error in
            if let error = error {
            print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    // ㄹinal step is to create an instance of DataController and send it into SwiftUI’s environment. (Global file)
    
}


