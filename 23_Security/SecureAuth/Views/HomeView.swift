import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if viewModel.isAuthenticated {
                NavigationView {
                    List {
                        Section {
                            Text("안전하게 로그인되었습니다!")
                                .foregroundColor(.green)
                        }
                        
                        Section {
                            Button("로그아웃", role: .destructive) {
                                viewModel.logout()
                            }
                        }
                    }
                    .navigationTitle("홈")
                }
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    HomeView()
}
