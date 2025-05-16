# Design Patterns Example - Todo App (MVVM)

이 예제는 MVVM (Model-View-ViewModel) 아키텍처 패턴을 보여주는 할 일 관리 앱입니다.

## 주요 학습 포인트

1. MVVM 아키텍처
   - Model: 데이터 구조와 비즈니스 로직
   - View: UI 컴포넌트
   - ViewModel: View와 Model 사이의 중재자

2. 디자인 패턴
   - Dependency Injection
   - Protocol-Oriented Programming
   - Observer Pattern (@Published)
   - Repository Pattern

## 프로젝트 구조

```
TodoApp/
├── Models/
│   └── Todo.swift
├── ViewModels/
│   └── TodoViewModel.swift
├── Views/
│   ├── TodoListView.swift
│   └── NewTodoView.swift
├── Services/
│   └── TodoService.swift
└── TodoApp.swift
```

## MVVM 구현

1. Model (Todo.swift)
   - 데이터 구조 정의
   - 비즈니스 로직 캡슐화

2. ViewModel (TodoViewModel.swift)
   - UI 상태 관리
   - 비즈니스 로직 조정
   - 데이터 변환

3. View (TodoListView.swift, NewTodoView.swift)
   - UI 컴포넌트
   - 사용자 입력 처리
   - ViewModel과의 데이터 바인딩

4. Service (TodoService.swift)
   - 데이터 저장소 추상화
   - Repository 패턴 구현

## 주요 기능

- 할 일 추가, 조회, 수정, 삭제
- 우선순위 설정
- 마감일 지정
- 완료 상태 토글
- 데이터 영속성 (UserDefaults 사용)

## 구현된 디자인 패턴

1. MVVM
```swift
// ViewModel
class TodoViewModel: ObservableObject {
    @Published var todos: [Todo] = []
    // ...
}

// View
struct TodoListView: View {
    @StateObject private var viewModel = TodoViewModel()
    // ...
}
```

2. Dependency Injection
```swift
protocol TodoServiceProtocol {
    func fetchTodos() async throws -> [Todo]
    // ...
}

class TodoViewModel {
    private let todoService: TodoServiceProtocol
    // ...
}
```

3. Repository Pattern
```swift
class TodoService: TodoServiceProtocol {
    private let userDefaults = UserDefaults.standard
    // ...
}
```

## 참고사항

이 예제는 다음과 같은 Swift와 SwiftUI의 최신 기능들을 활용합니다:
- Property Wrappers (@Published, @StateObject)
- Protocol-Oriented Programming
- Async/await
- SwiftUI Data Flow
