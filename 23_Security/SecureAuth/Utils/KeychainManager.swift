import Foundation
import Security

enum KeychainError: Error {
    case duplicateEntry
    case unknown(OSStatus)
    case itemNotFound
    case invalidItemFormat
    case unhandledError(status: OSStatus)
}

class KeychainManager {
    static let shared = KeychainManager()
    private init() {}
    
    func saveCredentials(username: String, password: String) throws {
        let credentials = "\(username):\(password)".data(using: .utf8)!
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "userCredentials",
            kSecValueData as String: credentials,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            try updateCredentials(username: username, password: password)
        } else if status != errSecSuccess {
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    func updateCredentials(username: String, password: String) throws {
        let credentials = "\(username):\(password)".data(using: .utf8)!
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "userCredentials"
        ]
        
        let attributes: [String: Any] = [
            kSecValueData as String: credentials
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        
        guard status == errSecSuccess else {
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    func getCredentials() throws -> (username: String, password: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "userCredentials",
            kSecReturnData as String: true
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess,
              let data = result as? Data,
              let credentials = String(data: data, encoding: .utf8) else {
            throw KeychainError.itemNotFound
        }
        
        let components = credentials.split(separator: ":")
        guard components.count == 2 else {
            throw KeychainError.invalidItemFormat
        }
        
        return (String(components[0]), String(components[1]))
    }
    
    func deleteCredentials() throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "userCredentials"
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    func isAuthenticated() -> Bool {
        do {
            _ = try getCredentials()
            return true
        } catch {
            return false
        }
    }
}
