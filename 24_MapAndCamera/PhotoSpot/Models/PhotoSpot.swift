import Foundation
import CoreLocation

struct PhotoSpot: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let imageFileName: String
    let latitude: Double
    let longitude: Double
    let createdAt: Date
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func mock() -> PhotoSpot {
        PhotoSpot(
            id: UUID(),
            title: "테스트 장소",
            description: "테스트 설명",
            imageFileName: "test_image",
            latitude: 37.5665,
            longitude: 126.9780,
            createdAt: Date()
        )
    }
}
