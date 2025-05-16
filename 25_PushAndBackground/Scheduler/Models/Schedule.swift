import Foundation

struct Schedule: Identifiable, Codable {
    let id: UUID
    var title: String
    var description: String
    var dateTime: Date
    var isCompleted: Bool
    var notificationEnabled: Bool
    var notificationId: String?
    
    static func mock() -> Schedule {
        Schedule(
            id: UUID(),
            title: "테스트 일정",
            description: "테스트 설명",
            dateTime: Date().addingTimeInterval(3600),
            isCompleted: false,
            notificationEnabled: true,
            notificationId: nil
        )
    }
}
