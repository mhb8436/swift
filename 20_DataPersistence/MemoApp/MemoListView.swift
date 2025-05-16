import SwiftUI
import CoreData

struct MemoListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Memo.createdAt, ascending: false)],
        animation: .default)
    private var memos: FetchedResults<Memo>
    
    @State private var isShowingNewMemo = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(memos) { memo in
                    NavigationLink {
                        MemoDetailView(memo: memo)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(memo.title ?? "")
                                .font(.headline)
                            Text(memo.content ?? "")
                                .font(.subheadline)
                                .lineLimit(2)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: deleteMemos)
            }
            .navigationTitle("메모")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isShowingNewMemo = true }) {
                        Label("새 메모", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingNewMemo) {
                NewMemoView()
            }
        }
    }
    
    private func deleteMemos(offsets: IndexSet) {
        withAnimation {
            offsets.map { memos[$0] }.forEach(viewContext.delete)
            try? viewContext.save()
        }
    }
}

#Preview {
    MemoListView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
