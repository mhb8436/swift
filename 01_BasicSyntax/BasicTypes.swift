// Swift의 기본 타입과 TypeScript 비교
// TypeScript: let name: string = "John"
let name: String = "John"

// TypeScript: let age: number = 30
let age: Int = 30

// TypeScript: let height: number = 1.75
let height: Double = 1.75

// TypeScript: let isActive: boolean = true
let isActive: Bool = true

// Swift의 옵셔널 타입 (TypeScript의 null | undefined와 유사하지만 더 안전함)
// TypeScript: let email: string | null = null
var email: String? = nil

// 옵셔널 바인딩 (TypeScript의 null 체크와 유사)
if let email = email {
    print("Email is: \(email)")
} else {
    print("No email provided")
}

// 타입 추론 (TypeScript와 동일하게 작동)
let inferredString = "Hello" // String 타입으로 추론
let inferredNumber = 42 // Int 타입으로 추론

// 튜플 (TypeScript의 튜플과 유사)
// TypeScript: let tuple: [string, number] = ["John", 30]
let person: (String, Int) = ("John", 30)

// 튜플 요소 접근
let (personName, personAge) = person
print("Name: \(personName), Age: \(personAge)")

// 타입 별칭 (TypeScript의 type과 유사)
// TypeScript: type Point = { x: number; y: number }
typealias Point = (x: Int, y: Int)

let origin: Point = (x: 0, y: 0)
print("Origin point: \(origin.x), \(origin.y)")

// 상수와 변수
// TypeScript: const PI = 3.14
let PI = 3.14 // 상수 (let)

// TypeScript: let count = 0
var count = 0 // 변수 (var)
count += 1

// 문자열 보간법 (TypeScript의 템플릿 리터럴과 유사)
// TypeScript: `Hello, ${name}!`
let greeting = "Hello, \(name)!"

// 타입 변환
// TypeScript: Number("42")
let numberString = "42"
let number = Int(numberString) // 옵셔널 Int 반환

// 타입 체크
// TypeScript: typeof value === "string"
let value: Any = "Hello"
if value is String {
    print("Value is a String")
}

// 타입 캐스팅
// TypeScript: value as string
if let stringValue = value as? String {
    print("String value: \(stringValue)")
} 