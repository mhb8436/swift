import Foundation

struct Workout: Identifiable, Codable {
    let id: UUID
    var type: WorkoutType
    var duration: TimeInterval
    var calories: Int
    var date: Date
    
    static func mock() -> Workout {
        Workout(
            id: UUID(),
            type: .running,
            duration: 1800, // 30분
            calories: 250,
            date: Date()
        )
    }
}

enum WorkoutType: String, Codable, CaseIterable {
    case running = "달리기"
    case cycling = "자전거"
    case swimming = "수영"
    case walking = "걷기"
    
    var icon: String {
        switch self {
        case .running: return "figure.run"
        case .cycling: return "figure.outdoor.cycle"
        case .swimming: return "figure.pool.swim"
        case .walking: return "figure.walk"
        }
    }
}
