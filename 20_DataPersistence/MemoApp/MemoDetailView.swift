import SwiftUI

struct MemoDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    let memo: Memo
    @State private var title: String
    @State private var content: String
    
    init(memo: Memo) {
        self.memo = memo
        _title = State(initialValue: memo.title ?? "")
        _content = State(initialValue: memo.content ?? "")
    }
    
    var body: some View {
        Form {
            TextField("제목", text: $title)
            TextEditor(text: $content)
                .frame(height: 200)
        }
        .navigationTitle("메모 수정")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("저장") {
                    saveMemo()
                }
            }
        }
    }
    
    private func saveMemo() {
        if viewContext.hasChanges {
            memo.title = title
            memo.content = content
            do {
                try viewContext.save()
                dismiss()
            } catch {
                print("메모 저장 중 오류 발생: \(error)")
            }
        } else {
            dismiss()
        }
    }
}
