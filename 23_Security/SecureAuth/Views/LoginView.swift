import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var username = ""
    @State private var password = ""
    @State private var isShowingRegistration = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("사용자 이름", text: $username)
                        .textContentType(.username)
                        .autocapitalization(.none)
                    
                    SecureField("비밀번호", text: $password)
                        .textContentType(.password)
                }
                
                Section {
                    Button(action: login) {
                        HStack {
                            Spacer()
                            if viewModel.isLoading {
                                ProgressView()
                            } else {
                                Text("로그인")
                            }
                            Spacer()
                        }
                    }
                    .disabled(username.isEmpty || password.isEmpty || viewModel.isLoading)
                }
                
                Section {
                    Button("계정이 없으신가요? 회원가입") {
                        isShowingRegistration = true
                    }
                    .foregroundColor(.blue)
                }
            }
            .navigationTitle("로그인")
            .alert("오류", isPresented: $viewModel.isShowingError) {
                Button("확인") {}
            } message: {
                Text(viewModel.errorMessage ?? "알 수 없는 오류가 발생했습니다.")
            }
            .sheet(isPresented: $isShowingRegistration) {
                RegistrationView()
            }
        }
    }
    
    private func login() {
        Task {
            await viewModel.login(username: username, password: password)
        }
    }
}

#Preview {
    LoginView()
}
