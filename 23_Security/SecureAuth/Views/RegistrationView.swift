import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = AuthViewModel()
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("사용자 이름", text: $username)
                        .textContentType(.username)
                        .autocapitalization(.none)
                    
                    TextField("이메일", text: $email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    SecureField("비밀번호", text: $password)
                        .textContentType(.newPassword)
                    
                    SecureField("비밀번호 확인", text: $confirmPassword)
                        .textContentType(.newPassword)
                }
                
                Section {
                    Button(action: register) {
                        HStack {
                            Spacer()
                            if viewModel.isLoading {
                                ProgressView()
                            } else {
                                Text("회원가입")
                            }
                            Spacer()
                        }
                    }
                    .disabled(!isValidForm || viewModel.isLoading)
                }
            }
            .navigationTitle("회원가입")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        dismiss()
                    }
                }
            }
            .alert("오류", isPresented: $viewModel.isShowingError) {
                Button("확인") {}
            } message: {
                Text(viewModel.errorMessage ?? "알 수 없는 오류가 발생했습니다.")
            }
        }
    }
    
    private var isValidForm: Bool {
        !username.isEmpty &&
        !email.isEmpty &&
        !password.isEmpty &&
        password == confirmPassword &&
        password.count >= 8
    }
    
    private func register() {
        Task {
            await viewModel.register(
                username: username,
                email: email,
                password: password
            )
            if !viewModel.isShowingError {
                dismiss()
            }
        }
    }
}

#Preview {
    RegistrationView()
}
