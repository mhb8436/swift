import SwiftUI
import CoreLocation
import MapKit

@MainActor
class PhotoSpotViewModel: ObservableObject {
    @Published var spots: [PhotoSpot] = []
    @Published var selectedSpot: PhotoSpot?
    @Published var isShowingNewSpot = false
    @Published var error: Error?
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    private let imageManager = ImageManager.shared
    
    init() {
        // 실제 앱에서는 저장된 데이터를 로드
        spots = [PhotoSpot.mock()]
    }
    
    func addPhotoSpot(title: String, description: String, image: UIImage, coordinate: CLLocationCoordinate2D) {
        do {
            let fileName = try imageManager.saveImage(image, withName: title)
            
            let spot = PhotoSpot(
                id: UUID(),
                title: title,
                description: description,
                imageFileName: fileName,
                latitude: coordinate.latitude,
                longitude: coordinate.longitude,
                createdAt: Date()
            )
            
            spots.append(spot)
            // 실제 앱에서는 여기서 데이터를 저장
            
        } catch {
            self.error = error
        }
    }
    
    func loadImage(for spot: PhotoSpot) -> UIImage? {
        try? imageManager.loadImage(fileName: spot.imageFileName)
    }
    
    func updateRegion(for coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }
}
