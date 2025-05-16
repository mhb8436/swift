import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case userNotFound
    case weakPassword
    case invalidEmail
    case networkError
    case unknown
    
    var description: String {
        switch self {
        case .invalidCredentials:
            return "잘못된 사용자 이름 또는 비밀번호입니다."
        case .userNotFound:
            return "사용자를 찾을 수 없습니다."
        case .weakPassword:
            return "비밀번호는 최소 8자 이상이며, 대문자, 소문자, 숫자, 특수문자를 포함해야 합니다."
        case .invalidEmail:
            return "유효하지 않은 이메일 형식입니다."
        case .networkError:
            return "네트워크 오류가 발생했습니다."
        case .unknown:
            return "알 수 없는 오류가 발생했습니다."
        }
    }
}

class AuthenticationService {
    private let keychainManager = KeychainManager.shared
    
    // 실제 앱에서는 서버와 통신하여 인증을 처리합니다.
    // 이 예제에서는 간단한 시뮬레이션을 합니다.
    func login(username: String, password: String) async throws {
        // 서버 통신 시뮬레이션
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // 예제를 위한 간단한 검증
        guard !username.isEmpty && !password.isEmpty else {
            throw AuthenticationError.invalidCredentials
        }
        
        // 인증 성공 시 Keychain에 저장
        try keychainManager.saveCredentials(username: username, password: password)
    }
    
    func register(username: String, email: String, password: String) async throws {
        // 입력 유효성 검사
        guard User.isValidEmail(email) else {
            throw AuthenticationError.invalidEmail
        }
        
        guard User.isValidPassword(password) else {
            throw AuthenticationError.weakPassword
        }
        
        // 서버 통신 시뮬레이션
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // 등록 성공 시 자동 로그인
        try await login(username: username, password: password)
    }
    
    func logout() throws {
        try keychainManager.deleteCredentials()
    }
    
    func getCurrentUser() throws -> User? {
        guard let credentials = try? keychainManager.getCredentials() else {
            return nil
        }
        
        // 실제 앱에서는 서버에서 사용자 정보를 가져옵니다.
        return User(
            username: credentials.username,
            email: "\(credentials.username)@example.com",
            password: credentials.password
        )
    }
    
    var isAuthenticated: Bool {
        keychainManager.isAuthenticated()
    }
}
