import SwiftUI
import Combine

// @State (React의 useState와 유사)
// React: const [count, setCount] = useState(0);
struct StateExample: View {
    @State private var count = 0
    @State private var text = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Count: \(count)")
                .font(.title)
            
            HStack(spacing: 20) {
                Button("Decrement") {
                    count -= 1
                }
                .buttonStyle(.bordered)
                
                Button("Increment") {
                    count += 1
                }
                .buttonStyle(.bordered)
            }
            
            TextField("Enter text", text: $text)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Text("You typed: \(text)")
        }
        .padding()
    }
}

// @Binding (React의 props와 유사)
// React: function Child({ value, onChange }) { ... }
struct BindingExample: View {
    @State private var parentValue = ""
    
    var body: some View {
        VStack {
            Text("Parent Value: \(parentValue)")
                .font(.headline)
            
            // 자식 뷰에 바인딩 전달
            ChildView(value: $parentValue)
        }
        .padding()
    }
}

struct ChildView: View {
    @Binding var value: String
    
    var body: some View {
        VStack {
            TextField("Enter text", text: $value)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Text("Child Value: \(value)")
        }
    }
}

// @ObservedObject (React의 Context와 유사)
// React: const [state, dispatch] = useReducer(reducer, initialState);
class CounterViewModel: ObservableObject {
    @Published var count = 0
    @Published var isRunning = false
    private var timer: Timer?
    
    func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.count += 1
        }
    }
    
    func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func reset() {
        count = 0
    }
}

struct ObservedObjectExample: View {
    @StateObject private var viewModel = CounterViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Count: \(viewModel.count)")
                .font(.title)
            
            HStack(spacing: 20) {
                Button(viewModel.isRunning ? "Stop" : "Start") {
                    if viewModel.isRunning {
                        viewModel.stopTimer()
                    } else {
                        viewModel.startTimer()
                    }
                }
                .buttonStyle(.bordered)
                
                Button("Reset") {
                    viewModel.reset()
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
    }
}

// @EnvironmentObject (React의 Context.Provider와 유사)
// React: <ThemeContext.Provider value={theme}>
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

struct EnvironmentObjectExample: View {
    @StateObject private var themeManager = ThemeManager()
    
    var body: some View {
        // 환경 객체 주입
        ThemeView()
            .environmentObject(themeManager)
    }
}

struct ThemeView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Theme Settings")
                .font(.title)
            
            Toggle("Dark Mode", isOn: $themeManager.isDarkMode)
                .padding()
            
            HStack {
                Text("Accent Color:")
                ColorPicker("", selection: $themeManager.accentColor)
            }
            .padding()
            
            // 테마가 적용된 컨텐츠
            ContentView()
        }
        .padding()
        .background(themeManager.isDarkMode ? Color.black : Color.white)
        .foregroundColor(themeManager.isDarkMode ? Color.white : Color.black)
    }
}

struct ContentView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        VStack {
            Text("This is themed content")
                .foregroundColor(themeManager.accentColor)
            
            Button("Toggle Theme") {
                themeManager.toggleTheme()
            }
            .buttonStyle(.bordered)
            .tint(themeManager.accentColor)
        }
    }
}

// @AppStorage (React의 localStorage와 유사)
// React: localStorage.setItem('key', value);
struct AppStorageExample: View {
    @AppStorage("username") private var username = ""
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    var body: some View {
        VStack(spacing: 20) {
            if isLoggedIn {
                Text("Welcome, \(username)!")
                    .font(.title)
                
                Button("Logout") {
                    isLoggedIn = false
                    username = ""
                }
                .buttonStyle(.bordered)
            } else {
                TextField("Enter username", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Button("Login") {
                    isLoggedIn = true
                }
                .buttonStyle(.bordered)
                .disabled(username.isEmpty)
            }
        }
        .padding()
    }
}

// 프리뷰
struct StateManagement_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StateExample()
            BindingExample()
            ObservedObjectExample()
            EnvironmentObjectExample()
            AppStorageExample()
        }
    }
} 