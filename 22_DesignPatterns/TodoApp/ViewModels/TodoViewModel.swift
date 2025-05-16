import Foundation

@MainActor
class TodoViewModel: ObservableObject {
    @Published var todos: [Todo] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let todoService: TodoServiceProtocol
    
    init(todoService: TodoServiceProtocol = TodoService()) {
        self.todoService = todoService
    }
    
    func loadTodos() {
        isLoading = true
        error = nil
        
        Task {
            do {
                todos = try await todoService.fetchTodos()
            } catch {
                self.error = error
            }
            isLoading = false
        }
    }
    
    func addTodo(title: String, priority: Todo.Priority, dueDate: Date?) {
        let todo = Todo(id: UUID(), title: title, isCompleted: false, priority: priority, dueDate: dueDate)
        
        Task {
            do {
                try await todoService.addTodo(todo)
                todos.append(todo)
            } catch {
                self.error = error
            }
        }
    }
    
    func toggleTodo(_ todo: Todo) {
        var updatedTodo = todo
        updatedTodo.isCompleted.toggle()
        
        Task {
            do {
                try await todoService.updateTodo(updatedTodo)
                if let index = todos.firstIndex(where: { $0.id == todo.id }) {
                    todos[index] = updatedTodo
                }
            } catch {
                self.error = error
            }
        }
    }
    
    func deleteTodo(_ todo: Todo) {
        Task {
            do {
                try await todoService.deleteTodo(todo.id)
                todos.removeAll { $0.id == todo.id }
            } catch {
                self.error = error
            }
        }
    }
}
