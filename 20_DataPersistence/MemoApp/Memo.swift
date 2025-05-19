import Foundation
import CoreData

@objc(Memo)
public class Memo: NSManagedObject {
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var createdAt: Date?
}

extension Memo {
    static func fetchRequest() -> NSFetchRequest<Memo> {
        return NSFetchRequest<Memo>(entityName: "Memo")
    }
}

extension Memo: Identifiable {
    public var id: NSManagedObjectID { objectID }
}
