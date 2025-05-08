import SwiftUI

// 기본 폼 (React의 form과 유사)
// React: <form onSubmit={handleSubmit}>
struct BasicForm: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isRememberMe = false
    
    var body: some View {
        Form {
            Section(header: Text("Login Information")) {
                TextField("Username", text: $username)
                    .textContentType(.username)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .textContentType(.password)
                
                Toggle("Remember Me", isOn: $isRememberMe)
            }
            
            Section {
                Button("Login") {
                    // Handle login
                }
                .frame(maxWidth: .infinity)
                .disabled(username.isEmpty || password.isEmpty)
            }
        }
        .navigationTitle("Basic Form")
    }
}

// 유효성 검사가 있는 폼 (React의 form validation과 유사)
// React: const [errors, setErrors] = useState({});
struct ValidationForm: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errors: [String: String] = [:]
    
    var isValid: Bool {
        errors.isEmpty && !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty
    }
    
    func validateEmail() {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if !emailPredicate.evaluate(with: email) {
            errors["email"] = "Please enter a valid email address"
        } else {
            errors.removeValue(forKey: "email")
        }
    }
    
    func validatePassword() {
        if password.count < 8 {
            errors["password"] = "Password must be at least 8 characters"
        } else {
            errors.removeValue(forKey: "password")
        }
        
        if password != confirmPassword {
            errors["confirmPassword"] = "Passwords do not match"
        } else {
            errors.removeValue(forKey: "confirmPassword")
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Registration")) {
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .onChange(of: email) { _ in validateEmail() }
                
                if let error = errors["email"] {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                SecureField("Password", text: $password)
                    .textContentType(.newPassword)
                    .onChange(of: password) { _ in validatePassword() }
                
                if let error = errors["password"] {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .textContentType(.newPassword)
                    .onChange(of: confirmPassword) { _ in validatePassword() }
                
                if let error = errors["confirmPassword"] {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
            
            Section {
                Button("Register") {
                    // Handle registration
                }
                .frame(maxWidth: .infinity)
                .disabled(!isValid)
            }
        }
        .navigationTitle("Validation Form")
    }
}

// 동적 폼 (React의 dynamic form fields와 유사)
// React: const [fields, setFields] = useState([{ id: 1, value: '' }]);
struct DynamicForm: View {
    struct FormField: Identifiable {
        let id = UUID()
        var value: String
    }
    
    @State private var fields: [FormField] = [FormField(value: "")]
    @State private var title = ""
    
    var body: some View {
        Form {
            Section(header: Text("Form Title")) {
                TextField("Title", text: $title)
            }
            
            Section(header: Text("Dynamic Fields")) {
                ForEach($fields) { $field in
                    TextField("Field", text: $field.value)
                }
                
                Button("Add Field") {
                    fields.append(FormField(value: ""))
                }
            }
            
            Section {
                Button("Submit") {
                    // Handle submission
                }
                .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("Dynamic Form")
    }
}

// 커스텀 입력 필드 (React의 custom input components와 유사)
// React: <CustomInput value={value} onChange={handleChange} />
struct CustomInputForm: View {
    @State private var rating = 3
    @State private var selectedDate = Date()
    @State private var selectedColor = Color.blue
    
    var body: some View {
        Form {
            Section(header: Text("Custom Inputs")) {
                VStack(alignment: .leading) {
                    Text("Rating")
                        .font(.headline)
                    
                    HStack {
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: star <= rating ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                                .onTapGesture {
                                    rating = star
                                }
                        }
                    }
                }
                
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                
                ColorPicker("Select Color", selection: $selectedColor)
            }
            
            Section {
                Button("Save") {
                    // Handle save
                }
                .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("Custom Inputs")
    }
}

// 프리뷰
struct Forms_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Group {
                BasicForm()
                ValidationForm()
                DynamicForm()
                CustomInputForm()
            }
        }
    }
} 