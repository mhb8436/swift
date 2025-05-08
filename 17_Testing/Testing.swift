import SwiftUI
import XCTest

// 테스트할 모델
struct User: Identifiable {
    let id: String
    var name: String
    var email: String
}

// 테스트할 ViewModel
class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var error: String?
    
    func fetchUsers() {
        isLoading = true
        // 실제 앱에서는 API 호출
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.users = [
                User(id: "1", name: "John Doe", email: "john@example.com"),
                User(id: "2", name: "Jane Smith", email: "jane@example.com")
            ]
            self.isLoading = false
        }
    }
    
    func addUser(name: String, email: String) {
        let newUser = User(id: UUID().uuidString, name: name, email: email)
        users.append(newUser)
    }
    
    func deleteUser(at index: Int) {
        users.remove(at: index)
    }
}

// 테스트할 View
struct UserListView: View {
    @StateObject private var viewModel = UserViewModel()
    @State private var showingAddUser = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.users) { user in
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        Text(user.email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .onDelete { indexSet in
                    viewModel.deleteUser(at: indexSet.first!)
                }
            }
            .navigationTitle("Users")
            .toolbar {
                Button(action: { showingAddUser = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddUser) {
                AddUserView(viewModel: viewModel)
            }
            .onAppear {
                viewModel.fetchUsers()
            }
        }
    }
}

struct AddUserView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: UserViewModel
    @State private var name = ""
    @State private var email = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Email", text: $email)
            }
            .navigationTitle("Add User")
            .toolbar {
                Button("Save") {
                    viewModel.addUser(name: name, email: email)
                    dismiss()
                }
                .disabled(name.isEmpty || email.isEmpty)
            }
        }
    }
}

// ViewModel 테스트
class UserViewModelTests: XCTestCase {
    var viewModel: UserViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = UserViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testAddUser() {
        // Given
        let name = "Test User"
        let email = "test@example.com"
        
        // When
        viewModel.addUser(name: name, email: email)
        
        // Then
        XCTAssertEqual(viewModel.users.count, 1)
        XCTAssertEqual(viewModel.users[0].name, name)
        XCTAssertEqual(viewModel.users[0].email, email)
    }
    
    func testDeleteUser() {
        // Given
        viewModel.addUser(name: "Test User", email: "test@example.com")
        XCTAssertEqual(viewModel.users.count, 1)
        
        // When
        viewModel.deleteUser(at: 0)
        
        // Then
        XCTAssertEqual(viewModel.users.count, 0)
    }
}

// View 테스트
struct UserListViewTests: View {
    var body: some View {
        UserListView()
    }
}

// UI 테스트
class UserListViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }
    
    func testAddUser() {
        // Given
        let addButton = app.navigationBars.buttons["plus"]
        
        // When
        addButton.tap()
        
        // Then
        let nameTextField = app.textFields["Name"]
        let emailTextField = app.textFields["Email"]
        let saveButton = app.buttons["Save"]
        
        XCTAssertTrue(nameTextField.exists)
        XCTAssertTrue(emailTextField.exists)
        XCTAssertTrue(saveButton.exists)
        XCTAssertFalse(saveButton.isEnabled)
    }
}

// 성능 테스트
class UserViewModelPerformanceTests: XCTestCase {
    var viewModel: UserViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = UserViewModel()
    }
    
    func testAddUserPerformance() {
        measure {
            for i in 0..<1000 {
                viewModel.addUser(name: "User \(i)", email: "user\(i)@example.com")
            }
        }
    }
}

// 프리뷰
struct Testing_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
} 