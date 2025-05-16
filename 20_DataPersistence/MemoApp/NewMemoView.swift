import SwiftUI

struct NewMemoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var content = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("제목", text: $title)
                TextEditor(text: $content)
                    .frame(height: 200)
            }
            .navigationTitle("새 메모")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("저장") {
                        saveMemo()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
    
    private func saveMemo() {
        let memo = Memo(context: viewContext)
        memo.id = UUID()
        memo.title = title
        memo.content = content
        memo.createdAt = Date()
        
        try? viewContext.save()
        dismiss()
    }
}
