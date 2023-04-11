//
//  Persistence.swift
//  Devote
//
//  Created by Oleksii Vasyliev on 11.04.2023.
//

import CoreData

struct PersistenceController {
	/// Persistent singleton
    static let shared = PersistenceController()
	/// Persistent container
    let container: NSPersistentContainer
	
	/// Creates new `PersistentController`
	/// - Parameter inMemory: Define if save data in memory, default `false`.
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Devote")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
	
	/// Preview.
	static var preview: PersistenceController = {
		let result = PersistenceController(inMemory: true)
		let viewContext = result.container.viewContext
		for _ in 0..<10 {
			let newItem = Item(context: viewContext)
			newItem.timestamp = Date()
		}
		do {
			try viewContext.save()
		} catch {
			let nsError = error as NSError
			fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
		}
		return result
	}()
}
