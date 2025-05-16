import SwiftUI

struct TodoListView: View {
    @StateObject private var viewModel = TodoViewModel()
    @State private var isShowingNewTodo = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(viewModel.todos) { todo in
                        TodoRowView(todo: todo) {
                            viewModel.toggleTodo(todo)
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            viewModel.deleteTodo(viewModel.todos[index])
                        }
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationTitle("할 일 목록")
            .toolbar {
                Button(action: { isShowingNewTodo = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isShowingNewTodo) {
                NewTodoView(viewModel: viewModel)
            }
            .alert("에러", isPresented: .constant(viewModel.error != nil)) {
                Button("확인") {
                    viewModel.error = nil
                }
            } message: {
                Text(viewModel.error?.localizedDescription ?? "알 수 없는 에러가 발생했습니다.")
            }
        }
        .onAppear {
            viewModel.loadTodos()
        }
    }
}

struct TodoRowView: View {
    let todo: Todo
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onToggle) {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(todo.isCompleted ? .green : .gray)
            }
            
            VStack(alignment: .leading) {
                Text(todo.title)
                    .strikethrough(todo.isCompleted)
                
                if let dueDate = todo.dueDate {
                    Text(dueDate.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Text(todo.priority.rawValue)
                .font(.caption)
                .padding(4)
                .background(Color(todo.priority.color).opacity(0.2))
                .cornerRadius(4)
        }
    }
}
