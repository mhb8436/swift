// Swift의 프로토콜과 익스텐션과 TypeScript 비교

// 프로토콜 정의 (TypeScript의 인터페이스와 유사)
// TypeScript: interface Vehicle { start(): void; stop(): void; }
protocol Vehicle {
    var brand: String { get }
    var model: String { get }
    
    func start()
    func stop()
}

// 프로토콜 채택 (TypeScript의 implements와 유사)
// TypeScript: class Car implements Vehicle { ... }
class Car: Vehicle {
    let brand: String
    let model: String
    
    init(brand: String, model: String) {
        self.brand = brand
        self.model = model
    }
    
    func start() {
        print("\(brand) \(model) is starting")
    }
    
    func stop() {
        print("\(brand) \(model) is stopping")
    }
}

let car = Car(brand: "Tesla", model: "Model 3")
car.start()
car.stop()

// 프로토콜 확장 (TypeScript에는 직접적인 대응이 없음)
extension Vehicle {
    func honk() {
        print("\(brand) \(model) is honking")
    }
}

car.honk() // 프로토콜 확장을 통해 추가된 메서드 사용

// 프로토콜 상속
// TypeScript: interface ElectricVehicle extends Vehicle { charge(): void; }
protocol ElectricVehicle: Vehicle {
    var batteryLevel: Double { get set }
    func charge()
}

class ElectricCar: ElectricVehicle {
    let brand: String
    let model: String
    var batteryLevel: Double
    
    init(brand: String, model: String, batteryLevel: Double) {
        self.brand = brand
        self.model = model
        self.batteryLevel = batteryLevel
    }
    
    func start() {
        print("\(brand) \(model) is starting silently")
    }
    
    func stop() {
        print("\(brand) \(model) is stopping")
    }
    
    func charge() {
        print("\(brand) \(model) is charging")
        batteryLevel = 100.0
    }
}

let electricCar = ElectricCar(brand: "Tesla", model: "Model S", batteryLevel: 75.0)
electricCar.start()
electricCar.charge()
electricCar.honk() // Vehicle 프로토콜의 확장 메서드 사용

// 프로토콜을 타입으로 사용
func startVehicle(_ vehicle: Vehicle) {
    vehicle.start()
}

startVehicle(car)
startVehicle(electricCar)

// 프로토콜 연관 타입 (TypeScript의 제네릭과 유사)
// TypeScript: interface Container<T> { items: T[]; add(item: T): void; }
protocol Container {
    associatedtype Item
    var items: [Item] { get set }
    mutating func add(_ item: Item)
}

// 프로토콜 연관 타입 구현
struct Stack<Element>: Container {
    typealias Item = Element
    var items: [Element] = []
    
    mutating func add(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element? {
        return items.popLast()
    }
}

var intStack = Stack<Int>()
intStack.add(1)
intStack.add(2)
intStack.add(3)
print("Popped: \(intStack.pop() ?? 0)")

// 익스텐션 (TypeScript에는 직접적인 대응이 없음)
extension Int {
    func times(_ action: () -> Void) {
        for _ in 0..<self {
            action()
        }
    }
    
    var isEven: Bool {
        return self % 2 == 0
    }
}

3.times {
    print("Hello!")
}

print("Is 4 even? \(4.isEven)")

// 프로토콜 익스텐션에서 기본 구현 제공
protocol Describable {
    var description: String { get }
}

extension Describable {
    var description: String {
        return "This is a \(type(of: self))"
    }
}

class Product: Describable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

let product = Product(name: "iPhone")
print(product.description)

// 프로토콜 컴포지션
protocol Flyable {
    func fly()
}

protocol Swimmable {
    func swim()
}

// TypeScript: type FlyingSwimming = Flyable & Swimmable;
typealias FlyingSwimming = Flyable & Swimmable

class Duck: FlyingSwimming {
    func fly() {
        print("Duck is flying")
    }
    
    func swim() {
        print("Duck is swimming")
    }
}

let duck = Duck()
duck.fly()
duck.swim()

// 프로토콜 선택적 요구사항
@objc protocol OptionalProtocol {
    @objc optional func optionalMethod()
    func requiredMethod()
}

class OptionalClass: OptionalProtocol {
    func requiredMethod() {
        print("Required method called")
    }
}

let optionalInstance = OptionalClass()
optionalInstance.requiredMethod()
// optionalInstance.optionalMethod?() // 선택적 메서드 호출 