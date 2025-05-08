// Swift의 컬렉션 타입과 TypeScript 비교

// Array (TypeScript의 Array와 유사)
// TypeScript: const numbers: number[] = [1, 2, 3, 4, 5]
var numbers: [Int] = [1, 2, 3, 4, 5]

// 배열 요소 접근
let firstNumber = numbers[0]
print("First number: \(firstNumber)")

// 배열 수정
numbers.append(6) // TypeScript: numbers.push(6)
numbers.insert(0, at: 0) // TypeScript: numbers.unshift(0)

// 배열 순회
// TypeScript: numbers.forEach(num => console.log(num))
for number in numbers {
    print(number)
}

// 배열 고차 함수
// TypeScript: numbers.map(n => n * 2)
let doubled = numbers.map { $0 * 2 }
print("Doubled: \(doubled)")

// TypeScript: numbers.filter(n => n > 3)
let filtered = numbers.filter { $0 > 3 }
print("Filtered: \(filtered)")

// Dictionary (TypeScript의 Object와 유사)
// TypeScript: const person: { name: string; age: number } = { name: "John", age: 30 }
var person: [String: Any] = [
    "name": "John",
    "age": 30
]

// 딕셔너리 요소 접근
if let name = person["name"] as? String {
    print("Name: \(name)")
}

// 딕셔너리 수정
person["email"] = "john@example.com" // TypeScript: person.email = "john@example.com"
person.removeValue(forKey: "email") // TypeScript: delete person.email

// 딕셔너리 순회
// TypeScript: Object.entries(person).forEach(([key, value]) => console.log(key, value))
for (key, value) in person {
    print("\(key): \(value)")
}

// Set (TypeScript의 Set과 유사)
// TypeScript: const uniqueNumbers = new Set<number>([1, 2, 2, 3, 3, 4])
var uniqueNumbers: Set<Int> = [1, 2, 2, 3, 3, 4]
print("Unique numbers: \(uniqueNumbers)")

// Set 연산
let setA: Set<Int> = [1, 2, 3, 4]
let setB: Set<Int> = [3, 4, 5, 6]

// 합집합
let union = setA.union(setB)
print("Union: \(union)")

// 교집합
let intersection = setA.intersection(setB)
print("Intersection: \(intersection)")

// 차집합
let difference = setA.subtracting(setB)
print("Difference: \(difference)")

// 컬렉션 타입 변환
// Array to Set
let array = [1, 2, 2, 3, 3, 4]
let setFromArray = Set(array)
print("Set from array: \(setFromArray)")

// Array to Dictionary
let names = ["John", "Jane", "Bob"]
let nameDict = Dictionary(uniqueKeysWithValues: names.enumerated().map { ($0.offset, $0.element) })
print("Name dictionary: \(nameDict)")

// 컬렉션 타입의 공통 메서드
// isEmpty
print("Is numbers empty? \(numbers.isEmpty)")

// count
print("Number of elements: \(numbers.count)")

// contains
print("Contains 3? \(numbers.contains(3))")

// 컬렉션 타입의 정렬
// TypeScript: numbers.sort((a, b) => a - b)
numbers.sort()
print("Sorted numbers: \(numbers)")

// 역순 정렬
numbers.sort(by: >)
print("Reverse sorted numbers: \(numbers)") 