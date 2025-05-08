import SwiftUI

// 기본 네비게이션 (React Router의 <Link>와 유사)
// React: <Link to="/detail">Go to Detail</Link>
struct BasicNavigation: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Go to Detail View") {
                    DetailView()
                }
                
                NavigationLink("Go to Settings") {
                    SettingsView()
                }
            }
            .navigationTitle("Navigation Example")
        }
    }
}

struct DetailView: View {
    var body: some View {
        Text("This is a detail view")
            .navigationTitle("Detail")
    }
}

struct SettingsView: View {
    var body: some View {
        Text("This is a settings view")
            .navigationTitle("Settings")
    }
}

// 프로그래매틱 네비게이션 (React Router의 useNavigate와 유사)
// React: const navigate = useNavigate(); navigate('/detail');
struct ProgrammaticNavigation: View {
    @State private var isDetailViewActive = false
    @State private var isSettingsViewActive = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button("Go to Detail View") {
                    isDetailViewActive = true
                }
                .buttonStyle(.bordered)
                
                Button("Go to Settings") {
                    isSettingsViewActive = true
                }
                .buttonStyle(.bordered)
            }
            .navigationTitle("Programmatic Navigation")
            .navigationDestination(isPresented: $isDetailViewActive) {
                DetailView()
            }
            .navigationDestination(isPresented: $isSettingsViewActive) {
                SettingsView()
            }
        }
    }
}

// 딥 링크 (React Router의 URL 파라미터와 유사)
// React: <Route path="/user/:id" element={<UserProfile />} />
struct DeepLinkNavigation: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(1...5, id: \.self) { id in
                    NavigationLink("User \(id)") {
                        UserProfileView(userId: id)
                    }
                }
            }
            .navigationTitle("Users")
        }
    }
}

struct UserProfileView: View {
    let userId: Int
    
    var body: some View {
        VStack {
            Text("User Profile")
                .font(.title)
            Text("User ID: \(userId)")
        }
        .navigationTitle("User \(userId)")
    }
}

// 탭 기반 네비게이션 (React Router의 <Outlet>과 유사)
// React: <Route path="/" element={<Layout />}> <Route index element={<Home />} />
struct TabBasedNavigation: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct HomeView: View {
    var body: some View {
        NavigationView {
            Text("Home View")
                .navigationTitle("Home")
        }
    }
}

struct ProfileView: View {
    var body: some View {
        NavigationView {
            Text("Profile View")
                .navigationTitle("Profile")
        }
    }
}

// 모달 프레젠테이션 (React의 모달 컴포넌트와 유사)
// React: const [isModalOpen, setIsModalOpen] = useState(false);
struct ModalNavigation: View {
    @State private var isModalPresented = false
    
    var body: some View {
        Button("Show Modal") {
            isModalPresented = true
        }
        .buttonStyle(.bordered)
        .sheet(isPresented: $isModalPresented) {
            ModalView(isPresented: $isModalPresented)
        }
    }
}

struct ModalView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Text("This is a modal view")
                    .padding()
                
                Button("Dismiss") {
                    isPresented = false
                }
                .buttonStyle(.bordered)
            }
            .navigationTitle("Modal")
            .navigationBarItems(trailing: Button("Close") {
                isPresented = false
            })
        }
    }
}

// 네비게이션 스택 관리 (React Router의 중첩 라우팅과 유사)
// React: <Route path="/dashboard/*" element={<Dashboard />} />
struct NavigationStackExample: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Dashboard") {
                    DashboardView()
                }
                
                NavigationLink("Profile") {
                    ProfileView()
                }
            }
            .navigationTitle("Navigation Stack")
        }
    }
}

struct DashboardView: View {
    var body: some View {
        List {
            NavigationLink("Analytics") {
                Text("Analytics View")
            }
            
            NavigationLink("Reports") {
                Text("Reports View")
            }
        }
        .navigationTitle("Dashboard")
    }
}

// 프리뷰
struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BasicNavigation()
            ProgrammaticNavigation()
            DeepLinkNavigation()
            TabBasedNavigation()
            ModalNavigation()
            NavigationStackExample()
        }
    }
} 