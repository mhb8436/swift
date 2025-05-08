// Swift의 함수와 클로저와 TypeScript 비교

// 기본 함수 선언
// TypeScript: function greet(name: string): string { return `Hello, ${name}!`; }
func greet(name: String) -> String {
    return "Hello, \(name)!"
}

// 함수 호출
let greeting = greet(name: "John")
print(greeting)

// 다중 매개변수 함수
// TypeScript: function add(a: number, b: number): number { return a + b; }
func add(a: Int, b: Int) -> Int {
    return a + b
}

// 기본값이 있는 매개변수
// TypeScript: function greet(name: string, greeting: string = "Hello"): string { return `${greeting}, ${name}!`; }
func greet(name: String, greeting: String = "Hello") -> String {
    return "\(greeting), \(name)!"
}

// 가변 매개변수
// TypeScript: function sum(...numbers: number[]): number { return numbers.reduce((a, b) => a + b, 0); }
func sum(numbers: Int...) -> Int {
    return numbers.reduce(0, +)
}

// inout 매개변수 (참조로 전달)
// TypeScript에서는 직접적인 대응이 없음
func swapValues(a: inout Int, b: inout Int) {
    let temp = a
    a = b
    b = temp
}

var x = 5
var y = 10
swapValues(a: &x, b: &y)
print("x: \(x), y: \(y)")

// 함수 타입
// TypeScript: type MathFunction = (a: number, b: number) => number;
typealias MathFunction = (Int, Int) -> Int

let multiply: MathFunction = { a, b in
    return a * b
}

// 함수를 매개변수로 전달
// TypeScript: function calculate(a: number, b: number, operation: MathFunction): number { return operation(a, b); }
func calculate(a: Int, b: Int, operation: MathFunction) -> Int {
    return operation(a, b)
}

let result = calculate(a: 5, b: 3, operation: multiply)
print("Result: \(result)")

// 클로저 (TypeScript의 화살표 함수와 유사)
// TypeScript: const numbers = [1, 2, 3, 4, 5].map(n => n * 2);
let numbers = [1, 2, 3, 4, 5]
let doubled = numbers.map { $0 * 2 }
print("Doubled: \(doubled)")

// 클로저 축약 문법
// TypeScript: const isEven = (n: number): boolean => n % 2 === 0;
let isEven = { (n: Int) -> Bool in
    return n % 2 == 0
}

// 후행 클로저
// TypeScript: numbers.filter(n => n > 3)
let filtered = numbers.filter { $0 > 3 }
print("Filtered: \(filtered)")

// 캡처 값
// TypeScript: const createCounter = () => { let count = 0; return () => ++count; };
func createCounter() -> () -> Int {
    var count = 0
    return {
        count += 1
        return count
    }
}

let counter = createCounter()
print("Counter: \(counter())") // 1
print("Counter: \(counter())") // 2

// 클로저에서 self 사용
class Person {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func createGreeting() -> () -> String {
        return { [weak self] in
            guard let self = self else { return "Person is gone" }
            return "Hello, I'm \(self.name)"
        }
    }
}

let person = Person(name: "John")
let greeting = person.createGreeting()
print(greeting())

// 함수형 프로그래밍 예제
// TypeScript: const numbers = [1, 2, 3, 4, 5].filter(n => n % 2 === 0).map(n => n * 2);
let evenDoubled = numbers
    .filter { $0 % 2 == 0 }
    .map { $0 * 2 }
print("Even doubled: \(evenDoubled)")

// 고차 함수
// TypeScript: const reduce = (arr: number[], fn: (acc: number, curr: number) => number, initial: number): number => arr.reduce(fn, initial);
func reduce<T>(_ array: [T], _ initial: T, _ combine: (T, T) -> T) -> T {
    var result = initial
    for element in array {
        result = combine(result, element)
    }
    return result
}

let sum = reduce(numbers, 0, +)
print("Sum: \(sum)") 