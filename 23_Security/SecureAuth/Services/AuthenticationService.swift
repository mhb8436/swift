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
    private let baseURL = "http://localhost:3000/api"
    private let keychainManager = KeychainManager.shared
    
    struct AuthResponse: Codable {
        let token: String
    }
    
    struct UserResponse: Codable {
        let username: String
        let email: String
    }
    
    func login(username: String, password: String) async throws {
        guard let url = URL(string: "\(baseURL)/login") else {
            throw AuthenticationError.networkError
        }
        
        let body = ["username": username, "password": password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw AuthenticationError.networkError
            }
            
            if httpResponse.statusCode == 401 {
                throw AuthenticationError.invalidCredentials
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw AuthenticationError.networkError
            }
            
            let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
            try keychainManager.saveToken(authResponse.token)
        } catch {
            if let error = error as? AuthenticationError {
                throw error
            }
            throw AuthenticationError.networkError
        }
    }
    
    func register(username: String, email: String, password: String) async throws {
        guard User.isValidEmail(email) else {
            throw AuthenticationError.invalidEmail
        }
        
        guard User.isValidPassword(password) else {
            throw AuthenticationError.weakPassword
        }
        
        guard let url = URL(string: "\(baseURL)/register") else {
            throw AuthenticationError.networkError
        }
        
        let body = ["username": username, "email": email, "password": password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw AuthenticationError.networkError
            }
            
            if httpResponse.statusCode == 400 {
                throw AuthenticationError.userNotFound
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw AuthenticationError.networkError
            }
            
            let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
            try keychainManager.saveToken(authResponse.token)
        } catch {
            if let error = error as? AuthenticationError {
                throw error
            }
            throw AuthenticationError.networkError
        }
    }
    
    func logout() throws {
        try keychainManager.deleteToken()
    }
    
    func getCurrentUser() async throws -> User? {
        guard let token = try? keychainManager.getToken() else {
            return nil
        }
        
        guard let url = URL(string: "\(baseURL)/user") else {
            throw AuthenticationError.networkError
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw AuthenticationError.networkError
            }
            
            let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
            return User(username: userResponse.username, email: userResponse.email, password: "")
        } catch {
            throw AuthenticationError.networkError
        }
    }
    
    var isAuthenticated: Bool {
        keychainManager.isAuthenticated()
    }
}
