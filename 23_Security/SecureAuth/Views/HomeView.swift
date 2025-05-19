import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if viewModel.isAuthenticated {
                NavigationView {
                    List {
                        if let user = viewModel.currentUser {
                            Section("사용자 정보") {
                                LabeledContent("사용자 이름", value: user.username)
                                LabeledContent("이메일", value: user.email)
                            }
                        }
                        
                        Section {
                            Button("로그아웃", role: .destructive) {
                                viewModel.logout()
                            }
                        }
                    }
                    .navigationTitle("홈")
                    .refreshable {
                        await viewModel.loadCurrentUser()
                    }
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
