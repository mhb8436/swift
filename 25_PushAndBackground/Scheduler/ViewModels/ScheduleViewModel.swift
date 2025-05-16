import SwiftUI

@MainActor
class ScheduleViewModel: ObservableObject {
    @Published var schedules: [Schedule] = []
    @Published var error: Error?
    
    private let notificationManager = NotificationManager.shared
    
    init() {
        // 실제 앱에서는 저장된 데이터 로드
        schedules = [Schedule.mock()]
        
        // 알림 탭 처리
        NotificationCenter.default.addObserver(
            forName: Notification.Name("DidReceiveNotification"),
            object: nil,
            queue: .main
        ) { [weak self] notification in
            if let identifier = notification.userInfo?["identifier"] as? String {
                self?.handleNotificationTap(identifier: identifier)
            }
        }
    }
    
    func addSchedule(title: String, description: String, dateTime: Date, enableNotification: Bool) async {
        var schedule = Schedule(
            id: UUID(),
            title: title,
            description: description,
            dateTime: dateTime,
            isCompleted: false,
            notificationEnabled: enableNotification,
            notificationId: nil
        )
        
        if enableNotification {
            do {
                let identifier = try await notificationManager.scheduleNotification(for: schedule)
                schedule.notificationId = identifier
            } catch {
                self.error = error
                return
            }
        }
        
        schedules.append(schedule)
        // 실제 앱에서는 여기서 데이터 저장
    }
    
    func toggleComplete(_ schedule: Schedule) {
        if let index = schedules.firstIndex(where: { $0.id == schedule.id }) {
            schedules[index].isCompleted.toggle()
            // 실제 앱에서는 여기서 데이터 저장
        }
    }
    
    func deleteSchedule(_ schedule: Schedule) {
        if let notificationId = schedule.notificationId {
            notificationManager.removeNotification(withId: notificationId)
        }
        
        schedules.removeAll { $0.id == schedule.id }
        // 실제 앱에서는 여기서 데이터 저장
    }
    
    private func handleNotificationTap(identifier: String) {
        // 알림에 해당하는 일정 찾기
        if let schedule = schedules.first(where: { $0.notificationId == identifier }) {
            // 여기서 일정 상세 화면으로 이동하거나 다른 작업 수행
            print("Notification tapped for schedule: \(schedule.title)")
        }
    }
}
