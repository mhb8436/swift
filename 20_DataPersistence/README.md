# Data Persistence Example - Memo App

이 예제는 Swift에서 CoreData를 사용한 데이터 영속성 구현 방법을 보여주는 메모 앱입니다.

## 주요 학습 포인트

1. CoreData 설정 및 사용
2. CRUD (Create, Read, Update, Delete) 작업 구현
3. SwiftUI와 CoreData 통합
4. @FetchRequest를 사용한 데이터 조회
5. 데이터 변경사항 저장 및 관리

## 프로젝트 구조

- `PersistenceController.swift`: CoreData 설정 및 관리
- `MemoListView.swift`: 메모 목록 화면
- `MemoDetailView.swift`: 메모 상세/수정 화면
- `NewMemoView.swift`: 새 메모 작성 화면
- `MemoApp.swift`: 앱 진입점

## 주요 기능

- 메모 작성, 조회, 수정, 삭제
- 메모 목록 정렬 (최신순)
- 영구 저장소에 데이터 저장
- 실시간 데이터 업데이트

## CoreData 모델

Memo 엔티티:

- id: UUID
- title: String
- content: String
- createdAt: Date

## 구현된 데이터 영속성 기능

1. 영구 저장소 설정
2. 컨텍스트 관리
3. 데이터 CRUD 작업
4. 자동 병합 정책
5. 에러 처리

## 참고사항

이 예제는 다음과 같은 SwiftUI와 CoreData의 주요 기능들을 활용합니다:

- @Environment
- @FetchRequest
- NSPersistentContainer
- NSManagedObjectContext
- Form과 List를 활용한 데이터 표시

## 실행 화면

데이터 영속성(Data Persistence) 예제로 CoreData를 사용하는 메모 앱을 만들었습니다. 이 예제의 주요 특징은 다음과 같습니다:

CoreData 통합
영구 저장소 설정
CRUD 작업 구현
데이터 모델 관리
현대적인 SwiftUI 통합
@Environment를 통한 CoreData 컨텍스트 접근
@FetchRequest를 사용한 데이터 조회
SwiftUI의 Form과 List 활용
주요 기능
메모 작성, 조회, 수정, 삭제
최신순 정렬
실시간 데이터 업데이트
이 앱을 실행하기 위해서는 Xcode에서 CoreData 모델 파일을 생성해야 합니다:

Xcode에서 새로운 프로젝트를 생성할 때 "Use Core Data" 옵션을 선택하거나
기존 프로젝트에 새로운 Core Data Model 파일을 추가
이 예제를 통해 iOS 앱에서 자주 사용되는 데이터 영속성 패턴을 학습할 수 있습니다.

다음 예제로 동시성(Concurrency) 관련 예제를 만들어드릴까요?
