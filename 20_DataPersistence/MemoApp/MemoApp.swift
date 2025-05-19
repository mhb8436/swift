import SwiftUI

@main
struct MemoApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            MemoListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
