import SwiftUI
import CoreData

// Create Core Data class for Memory entity
@objc(Memory)
public class Memory: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var date: Date?
    @NSManaged public var para: String
}
extension Memory: Identifiable {

}

