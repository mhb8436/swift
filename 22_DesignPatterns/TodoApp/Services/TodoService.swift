import Foundation

protocol TodoServiceProtocol {
    func fetchTodos() async throws -> [Todo]
    func addTodo(_ todo: Todo) async throws
    func updateTodo(_ todo: Todo) async throws
    func deleteTodo(_ id: UUID) async throws
}

class TodoService: TodoServiceProtocol {
    private let userDefaults = UserDefaults.standard
    private let todoKey = "todos"
    
    func fetchTodos() async throws -> [Todo] {
        guard let data = userDefaults.data(forKey: todoKey) else { return [] }
        return try JSONDecoder().decode([Todo].self, from: data)
    }
    
    func addTodo(_ todo: Todo) async throws {
        var todos = try await fetchTodos()
        todos.append(todo)
        try saveTodos(todos)
    }
    
    func updateTodo(_ todo: Todo) async throws {
        var todos = try await fetchTodos()
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index] = todo
            try saveTodos(todos)
        }
    }
    
    func deleteTodo(_ id: UUID) async throws {
        var todos = try await fetchTodos()
        todos.removeAll { $0.id == id }
        try saveTodos(todos)
    }
    
    private func saveTodos(_ todos: [Todo]) throws {
        let data = try JSONEncoder().encode(todos)
        userDefaults.set(data, forKey: todoKey)
    }
}
