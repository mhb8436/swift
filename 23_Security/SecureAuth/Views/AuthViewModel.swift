import SwiftUI

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var isShowingError = false
    @Published var errorMessage: String?
    
    private let authService = AuthenticationService()
    
    init() {
        isAuthenticated = authService.isAuthenticated
    }
    
    func login(username: String, password: String) async {
        isLoading = true
        do {
            try await authService.login(username: username, password: password)
            isAuthenticated = true
        } catch let error as AuthenticationError {
            showError(error.description)
        } catch {
            showError("알 수 없는 오류가 발생했습니다.")
        }
        isLoading = false
    }
    
    func register(username: String, email: String, password: String) async {
        isLoading = true
        do {
            try await authService.register(username: username, email: email, password: password)
            isAuthenticated = true
        } catch let error as AuthenticationError {
            showError(error.description)
        } catch {
            showError("알 수 없는 오류가 발생했습니다.")
        }
        isLoading = false
    }
    
    func logout() {
        do {
            try authService.logout()
            isAuthenticated = false
        } catch {
            showError("로그아웃 중 오류가 발생했습니다.")
        }
    }
    
    private func showError(_ message: String) {
        errorMessage = message
        isShowingError = true
    }
}
