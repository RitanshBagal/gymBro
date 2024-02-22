import SwiftUI
import CoreData

// that file are the same file that xcode generated when Core Data option checked

// here the code

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for index in 0 ..< 10 {
            // here we will add data to our preview but first let's create our entity
            
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        // Creating the entity
        let memoryEntity = NSEntityDescription()
        memoryEntity.name = "Memory"
        memoryEntity.managedObjectClassName = "Memory"
        
        // now creating the attributes and append them to memory entity
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.type = .uuid
        memoryEntity.properties.append(idAttribute)
        
        let nameAttribute = NSAttributeDescription()
        nameAttribute.name = "name"
        nameAttribute.type = .string
        memoryEntity.properties.append(nameAttribute)
        let paraAttribute = NSAttributeDescription()
        paraAttribute.name = "para"
        paraAttribute.type = .string
        memoryEntity.properties.append(paraAttribute)
        let dateAttribute = NSAttributeDescription()
        dateAttribute.name = "date"
        dateAttribute.type = .date
        memoryEntity.properties.append(dateAttribute)
        
        // now let's create Core Data model
        let model = NSManagedObjectModel()
        model.entities = [memoryEntity]
        
        // we forget to that model to our container
        container = NSPersistentContainer(name: "Memories", managedObjectModel: model)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
