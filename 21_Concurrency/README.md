# Concurrency Example - Image Gallery App

이 예제는 Swift의 최신 동시성 기능을 보여주는 이미지 갤러리 앱입니다.

## 주요 학습 포인트

1. Swift Concurrency 기능
   - async/await
   - Actor
   - Task
   - TaskGroup
   - @MainActor

2. 동시성 패턴
   - 비동기 이미지 로딩
   - 동시 다운로드
   - 캐시 관리
   - 에러 처리

## 프로젝트 구조

- `ImageLoader.swift`: 이미지 로딩 및 캐시 로직
- `GalleryView.swift`: 갤러리 UI
- `ImageGalleryApp.swift`: 앱 진입점

## 주요 기능

1. 동시성 기능
   - Actor를 사용한 thread-safe 캐시
   - TaskGroup을 사용한 병렬 이미지 다운로드
   - async/await를 사용한 비동기 작업
   - @MainActor를 사용한 UI 업데이트

2. UI 기능
   - LazyVGrid를 사용한 이미지 그리드
   - 로딩 인디케이터
   - 새로고침 기능
   - 에러 처리 및 표시

## 구현된 동시성 패턴

1. Actor를 사용한 thread-safe 캐시
   ```swift
   actor ImageLoader {
       private var cache: [URL: Image] = [:]
       // ...
   }
   ```

2. TaskGroup을 사용한 병렬 다운로드
   ```swift
   try await withThrowingTaskGroup(of: (URL, Image).self) { group in
       for url in urls {
           group.addTask {
               // 병렬로 이미지 다운로드
           }
       }
   }
   ```

3. @MainActor를 사용한 UI 업데이트
   ```swift
   @MainActor
   class ImageViewModel: ObservableObject {
       // UI 관련 작업은 메인 스레드에서 처리
   }
   ```

## 참고사항

이 예제는 다음과 같은 Swift의 최신 동시성 기능들을 활용합니다:
- async/await 구문
- Actor 모델
- Task와 TaskGroup
- @MainActor 속성
- 구조화된 동시성
