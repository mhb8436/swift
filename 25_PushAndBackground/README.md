# Push Notification and Background Tasks Example - Scheduler App

이 예제는 푸시 알림과 백그라운드 작업을 활용하는 일정 관리 앱입니다.

## 주요 학습 포인트

1. 푸시 알림

   - 알림 권한 요청
   - 로컬 알림 스케줄링
   - 알림 처리
   - 알림 관리

2. 백그라운드 작업

   - BGTaskScheduler 활용
   - 백그라운드 앱 새로고침
   - 백그라운드 프로세싱
   - 작업 스케줄링

3. 일정 관리
   - CRUD 작업
   - 날짜/시간 처리
   - 상태 관리

## 프로젝트 구조

```
Scheduler/
├── Models/
│   └── Schedule.swift           # 일정 모델
├── ViewModels/
│   └── ScheduleViewModel.swift  # 일정 관리 뷰모델
├── Views/
│   ├── ScheduleListView.swift   # 일정 목록 화면
│   └── NewScheduleView.swift    # 새 일정 생성 화면
├── Services/
│   ├── NotificationManager.swift # 알림 관리
│   └── BackgroundTaskManager.swift # 백그라운드 작업 관리
└── SchedulerApp.swift          # 앱 진입점
```

## 주요 기능

1. 알림 관리

```swift
class NotificationManager {
    func scheduleNotification(for schedule: Schedule) async throws -> String {
        let content = UNMutableNotificationContent()
        content.title = schedule.title
        content.body = schedule.description
        // ...
    }
}
```

2. 백그라운드 작업

```swift
class BackgroundTaskManager {
    func registerBackgroundTasks() {
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: "com.example.scheduler.refresh",
            using: nil
        ) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
    }
}
```

3. 일정 관리

```swift
class ScheduleViewModel {
    func addSchedule(title: String, description: String, dateTime: Date, enableNotification: Bool) async {
        // 일정 추가 및 알림 설정
    }
}
```

## Info.plist 설정

다음 항목들을 Info.plist에 추가해야 합니다:

1. 알림 권한

```xml
<key>NSUserNotificationUsageDescription</key>
<string>일정 알림을 보내기 위해 알림 권한이 필요합니다.</string>
```

2. 백그라운드 모드

```xml
<key>UIBackgroundModes</key>
<array>
    <string>fetch</string>
    <string>processing</string>
</array>
```

3. 백그라운드 작업

```xml
<key>BGTaskSchedulerPermittedIdentifiers</key>
<array>
    <string>com.example.scheduler.refresh</string>
    <string>com.example.scheduler.processing</string>
</array>
```

## 구현된 기능

1. 알림 기능

   - 일정 시간에 로컬 알림
   - 알림 권한 관리
   - 알림 탭 처리
   - 알림 스케줄링

2. 백그라운드 작업

   - 주기적인 데이터 새로고침
   - 백그라운드 데이터 처리
   - 작업 스케줄링
   - 시간 초과 처리

3. 일정 관리
   - 일정 추가/삭제
   - 완료 상태 토글
   - 날짜/시간 선택
   - 알림 설정

## 참고사항

이 예제는 다음과 같은 iOS 프레임워크들을 활용합니다:

- UserNotifications
- BackgroundTasks
- SwiftUI
- Combine

실제 프로덕션 앱에서 추가로 구현할 수 있는 기능들:

- 원격 푸시 알림
- 일정 동기화
- 반복 일정
- 일정 공유
- 데이터 백업

## 참고 자료

이 앱을 실행하기 위해서는 Info.plist에 다음 설정들을 추가해야 합니다:

알림 권한 설명
백그라운드 모드 활성화
백그라운드 작업 식별자
