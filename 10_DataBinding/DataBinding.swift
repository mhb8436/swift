import SwiftUI

// 기본 데이터 바인딩 (React의 props와 유사)
// React: function ChildComponent({ data, onDataChange }) { ... }
struct BasicDataBinding: View {
    @State private var text = ""
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter text", text: $text)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            ChildView(text: text)
            
            Text("Parent View Text: \(text)")
        }
        .padding()
    }
}

struct ChildView: View {
    let text: String
    
    var body: some View {
        VStack {
            Text("Child View")
            Text("Received Text: \(text)")
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
}

// 양방향 바인딩 (React의 controlled components와 유사)
// React: <input value={value} onChange={(e) => setValue(e.target.value)} />
struct TwoWayBinding: View {
    @State private var name = ""
    @State private var age = ""
    @State private var isSubscribed = false
    
    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                TextField("Name", text: $name)
                TextField("Age", text: $age)
                    .keyboardType(.numberPad)
                Toggle("Subscribe to newsletter", isOn: $isSubscribed)
            }
            
            Section(header: Text("Preview")) {
                Text("Name: \(name)")
                Text("Age: \(age)")
                Text("Subscribed: \(isSubscribed ? "Yes" : "No")")
            }
        }
    }
}

// ObservableObject를 사용한 데이터 바인딩 (React의 Context와 유사)
// React: const UserContext = React.createContext();
class UserViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var isLoggedIn = false
    
    func login() {
        isLoggedIn = true
    }
    
    func logout() {
        isLoggedIn = false
        name = ""
        email = ""
    }
}

struct ObservableObjectBinding: View {
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if viewModel.isLoggedIn {
                VStack {
                    Text("Welcome, \(viewModel.name)!")
                    Text("Email: \(viewModel.email)")
                    Button("Logout") {
                        viewModel.logout()
                    }
                    .buttonStyle(.bordered)
                }
            } else {
                LoginView(viewModel: viewModel)
            }
        }
        .padding()
    }
}

struct LoginView: View {
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            TextField("Name", text: $viewModel.name)
                .textFieldStyle(.roundedBorder)
            
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
            
            Button("Login") {
                viewModel.login()
            }
            .buttonStyle(.bordered)
            .disabled(viewModel.name.isEmpty || viewModel.email.isEmpty)
        }
    }
}

// EnvironmentObject를 사용한 데이터 바인딩 (React의 Context.Provider와 유사)
// React: <UserContext.Provider value={userData}>
class ThemeManager: ObservableObject {
    @Published var isDarkMode = false
    @Published var accentColor = Color.blue
    
    func toggleTheme() {
        isDarkMode.toggle()
    }
    
    func setAccentColor(_ color: Color) {
        accentColor = color
    }
}

struct EnvironmentObjectBinding: View {
    @StateObject private var themeManager = ThemeManager()
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Theme Settings") {
                    ThemeSettingsView()
                }
                
                NavigationLink("Content View") {
                    ContentView()
                }
            }
            .navigationTitle("Theme Example")
        }
        .environmentObject(themeManager)
    }
}

struct ThemeSettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        Form {
            Toggle("Dark Mode", isOn: $themeManager.isDarkMode)
            
            ColorPicker("Accent Color", selection: $themeManager.accentColor)
        }
        .navigationTitle("Theme Settings")
    }
}

struct ContentView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Current Theme")
                .font(.title)
            
            Text(themeManager.isDarkMode ? "Dark Mode" : "Light Mode")
            
            Circle()
                .fill(themeManager.accentColor)
                .frame(width: 100, height: 100)
        }
        .padding()
    }
}

// 프리뷰
struct DataBinding_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BasicDataBinding()
            TwoWayBinding()
            ObservableObjectBinding()
            EnvironmentObjectBinding()
        }
    }
} 