import Foundation

struct User: Codable {
    let username: String
    let email: String
    
    // 실제 앱에서는 이런 민감한 정보를 모델에 저장하지 않습니다.
    // 이는 예제를 위한 것입니다.
    let password: String
    
    // 비밀번호 유효성 검사
    static func isValidPassword(_ password: String) -> Bool {
        // 최소 8자, 대문자, 소문자, 숫자, 특수문자 포함
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex)
            .evaluate(with: password)
    }
    
    // 이메일 유효성 검사
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex)
            .evaluate(with: email)
    }
}
