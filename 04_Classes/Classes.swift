// Swift의 클래스와 구조체와 TypeScript 비교

// 기본 클래스 정의
// TypeScript: class Person { name: string; age: number; }
class Person {
    // 프로퍼티 (TypeScript의 클래스 필드와 유사)
    var name: String
    var age: Int
    
    // 초기화 메서드 (TypeScript의 constructor와 유사)
    // TypeScript: constructor(name: string, age: number) { this.name = name; this.age = age; }
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    // 메서드 (TypeScript의 클래스 메서드와 유사)
    // TypeScript: greet(): string { return `Hello, I'm ${this.name}`; }
    func greet() -> String {
        return "Hello, I'm \(name)"
    }
}

// 클래스 인스턴스 생성
// TypeScript: const person = new Person("John", 30);
let person = Person(name: "John", age: 30)
print(person.greet())

// 상속
// TypeScript: class Employee extends Person { role: string; }
class Employee: Person {
    var role: String
    
    // 부모 클래스의 초기화 메서드 호출
    init(name: String, age: Int, role: String) {
        self.role = role
        super.init(name: name, age: age)
    }
    
    // 메서드 오버라이드
    // TypeScript: override greet(): string { return `Hello, I'm ${this.name} and I'm a ${this.role}`; }
    override func greet() -> String {
        return "Hello, I'm \(name) and I'm a \(role)"
    }
}

let employee = Employee(name: "Jane", age: 25, role: "Developer")
print(employee.greet())

// 구조체 (TypeScript에는 직접적인 대응이 없음)
// 구조체는 값 타입으로, 클래스는 참조 타입
struct Point {
    var x: Int
    var y: Int
    
    // 구조체의 메서드
    func distance(to other: Point) -> Double {
        let dx = Double(other.x - x)
        let dy = Double(other.y - y)
        return sqrt(dx * dx + dy * dy)
    }
}

// 구조체 인스턴스 생성
var point1 = Point(x: 0, y: 0)
var point2 = point1 // 값 복사

point2.x = 10
print("Point1: \(point1.x), \(point1.y)") // (0, 0)
print("Point2: \(point2.x), \(point2.y)") // (10, 0)

// 클래스와 구조체의 차이점
class Counter {
    var count = 0
    
    func increment() {
        count += 1
    }
}

let counter1 = Counter()
let counter2 = counter1 // 참조 복사

counter2.increment()
print("Counter1: \(counter1.count)") // 1
print("Counter2: \(counter2.count)") // 1

// 계산 프로퍼티 (TypeScript의 getter/setter와 유사)
// TypeScript: get fullName(): string { return `${this.firstName} ${this.lastName}`; }
class Name {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
        set {
            let components = newValue.split(separator: " ")
            if components.count == 2 {
                firstName = String(components[0])
                lastName = String(components[1])
            }
        }
    }
}

let name = Name(firstName: "John", lastName: "Doe")
print(name.fullName) // "John Doe"
name.fullName = "Jane Smith"
print(name.firstName) // "Jane"
print(name.lastName) // "Smith"

// 프로퍼티 옵저버 (TypeScript에는 직접적인 대응이 없음)
class Temperature {
    var celsius: Double = 0 {
        willSet {
            print("Celsius will be set to \(newValue)")
        }
        didSet {
            print("Celsius was set from \(oldValue) to \(celsius)")
        }
    }
    
    var fahrenheit: Double {
        get {
            return celsius * 9/5 + 32
        }
        set {
            celsius = (newValue - 32) * 5/9
        }
    }
}

let temp = Temperature()
temp.celsius = 25 // 프로퍼티 옵저버 호출
print("Fahrenheit: \(temp.fahrenheit)")

// 정적 프로퍼티와 메서드 (TypeScript의 static과 유사)
// TypeScript: static create(name: string): Person { return new Person(name); }
class MathUtils {
    static let pi = 3.14159
    
    static func square(_ number: Double) -> Double {
        return number * number
    }
}

print("Pi: \(MathUtils.pi)")
print("Square of 5: \(MathUtils.square(5))")

// 접근 제어 (TypeScript의 public, private, protected와 유사)
class BankAccount {
    private var balance: Double
    
    init(initialBalance: Double) {
        self.balance = initialBalance
    }
    
    func deposit(_ amount: Double) {
        balance += amount
    }
    
    func withdraw(_ amount: Double) -> Bool {
        if amount <= balance {
            balance -= amount
            return true
        }
        return false
    }
    
    func getBalance() -> Double {
        return balance
    }
}

let account = BankAccount(initialBalance: 1000)
account.deposit(500)
print("Balance: \(account.getBalance())") 