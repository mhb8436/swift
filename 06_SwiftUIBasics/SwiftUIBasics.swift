import SwiftUI

// SwiftUI의 기본 View 프로토콜 (React의 컴포넌트와 유사)
// React: function Greeting({ name }: { name: string }) { return <h1>Hello, {name}!</h1>; }
struct Greeting: View {
    let name: String
    
    var body: some View {
        Text("Hello, \(name)!")
            .font(.title)
            .foregroundColor(.blue)
    }
}

// 상태 관리 (React의 useState와 유사)
// React: const [count, setCount] = useState(0);
struct Counter: View {
    @State private var count = 0
    
    var body: some View {
        VStack {
            Text("Count: \(count)")
                .font(.headline)
            
            HStack {
                Button(action: {
                    count -= 1
                }) {
                    Text("-")
                        .font(.title)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    count += 1
                }) {
                    Text("+")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}

// 커스텀 뷰 모디파이어 (React의 HOC와 유사)
struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

// 뷰 모디파이어 확장
extension View {
    func cardStyle() -> some View {
        self.modifier(CardModifier())
    }
}

// 커스텀 뷰 사용
struct CardView: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            Text(content)
                .font(.body)
        }
        .cardStyle()
    }
}

// 리스트 뷰 (React의 map과 유사)
// React: {items.map(item => <Item key={item.id} {...item} />)}
struct ItemList: View {
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
    var body: some View {
        List(items, id: \.self) { item in
            Text(item)
        }
    }
}

// 네비게이션 (React Router와 유사)
struct NavigationExample: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: Text("Detail View 1")) {
                    Text("Go to Detail 1")
                }
                NavigationLink(destination: Text("Detail View 2")) {
                    Text("Go to Detail 2")
                }
            }
            .navigationTitle("Navigation Example")
        }
    }
}

// 폼 입력 (React의 controlled components와 유사)
// React: const [text, setText] = useState('');
struct FormExample: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        Form {
            TextField("Username", text: $username)
            SecureField("Password", text: $password)
            
            Button("Submit") {
                print("Username: \(username)")
                print("Password: \(password)")
            }
        }
    }
}

// 이미지와 비동기 로딩 (React의 이미지 컴포넌트와 유사)
struct ImageExample: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://example.com/image.jpg")) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            case .failure:
                Image(systemName: "photo")
                    .foregroundColor(.gray)
            @unknown default:
                EmptyView()
            }
        }
    }
}

// 애니메이션 (React의 CSS transitions와 유사)
struct AnimationExample: View {
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            Button("Toggle") {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            
            if isExpanded {
                Text("Expanded Content")
                    .transition(.scale)
            }
        }
    }
}

// 환경 객체 (React의 Context와 유사)
class UserSettings: ObservableObject {
    @Published var isDarkMode = false
    @Published var fontSize: CGFloat = 16
}

struct SettingsView: View {
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        Form {
            Toggle("Dark Mode", isOn: $settings.isDarkMode)
            Slider(value: $settings.fontSize, in: 12...24) {
                Text("Font Size")
            }
        }
    }
}

// 프리뷰 (React의 Storybook과 유사)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Greeting(name: "John")
            Counter()
            CardView(title: "Title", content: "Content")
            ItemList()
            NavigationExample()
            FormExample()
            ImageExample()
            AnimationExample()
        }
    }
} 