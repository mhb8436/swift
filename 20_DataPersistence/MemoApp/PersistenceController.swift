import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        // 프로그래밍 방식으로 CoreData 모델 생성
        let model = NSManagedObjectModel()
        
        // Memo 엔티티 정의
        let memoEntity = NSEntityDescription()
        memoEntity.name = "Memo"
        memoEntity.managedObjectClassName = "Memo"
        
        // 속성 정의
        let titleAttribute = NSAttributeDescription()
        titleAttribute.name = "title"
        titleAttribute.type = .stringAttributeType
        titleAttribute.isOptional = true
        
        let contentAttribute = NSAttributeDescription()
        contentAttribute.name = "content"
        contentAttribute.type = .stringAttributeType
        contentAttribute.isOptional = true
        
        let createdAtAttribute = NSAttributeDescription()
        createdAtAttribute.name = "createdAt"
        createdAtAttribute.type = .dateAttributeType
        createdAtAttribute.isOptional = true
        
        memoEntity.properties = [titleAttribute, contentAttribute, createdAtAttribute]
        model.entities = [memoEntity]
        
        // CoreData 컨테이너 생성
        container = NSPersistentContainer(name: "MemoApp", managedObjectModel: model)
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func save() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
