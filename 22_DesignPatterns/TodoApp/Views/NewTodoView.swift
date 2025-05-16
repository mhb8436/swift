import SwiftUI

struct NewTodoView: View {
    @Environment(\.dismiss) private var dismiss
    let viewModel: TodoViewModel
    
    @State private var title = ""
    @State private var priority = Todo.Priority.medium
    @State private var dueDate: Date = Date()
    @State private var hasDueDate = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("할 일", text: $title)
                
                Picker("우선순위", selection: $priority) {
                    ForEach(Todo.Priority.allCases, id: \.self) { priority in
                        Text(priority.rawValue).tag(priority)
                    }
                }
                
                Toggle("마감일", isOn: $hasDueDate)
                
                if hasDueDate {
                    DatePicker("마감일",
                             selection: $dueDate,
                             displayedComponents: [.date, .hourAndMinute])
                }
            }
            .navigationTitle("새 할 일")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("추가") {
                        viewModel.addTodo(
                            title: title,
                            priority: priority,
                            dueDate: hasDueDate ? dueDate : nil
                        )
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}
