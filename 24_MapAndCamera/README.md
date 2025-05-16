# Map and Camera Example - Photo Spot App

이 예제는 MapKit과 카메라/사진 라이브러리를 사용하는 위치 기반 사진 공유 앱입니다.

## 주요 학습 포인트

1. MapKit 활용
   - 지도 표시
   - 사용자 위치 추적
   - 커스텀 어노테이션
   - 지도 상호작용

2. 카메라와 사진 라이브러리
   - 카메라 접근
   - 사진 라이브러리 접근
   - 이미지 피커
   - 권한 관리

3. 위치 서비스
   - 위치 권한 요청
   - 위치 업데이트
   - 좌표 처리

## 프로젝트 구조

```
PhotoSpot/
├── Models/
│   └── PhotoSpot.swift          # 사진 스팟 모델
├── ViewModels/
│   └── PhotoSpotViewModel.swift  # 뷰모델
├── Views/
│   ├── MapView.swift            # 메인 지도 화면
│   ├── SpotDetailView.swift     # 스팟 상세 화면
│   └── NewSpotView.swift        # 새 스팟 생성 화면
├── Services/
│   ├── LocationManager.swift     # 위치 서비스
│   └── ImageManager.swift        # 이미지 처리
└── PhotoSpotApp.swift           # 앱 진입점
```

## 주요 기능

1. 지도 기능
```swift
Map(
    coordinateRegion: $viewModel.region,
    showsUserLocation: true,
    annotationItems: viewModel.spots
) { spot in
    MapAnnotation(coordinate: spot.coordinate) {
        SpotAnnotationView(spot: spot)
    }
}
```

2. 위치 서비스
```swift
class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    @Published var location: CLLocation?
    
    func requestLocationPermission() {
        manager.requestWhenInUseAuthorization()
    }
}
```

3. 카메라/갤러리 접근
```swift
struct ImagePicker: UIViewControllerRepresentable {
    let sourceType: UIImagePickerController.SourceType
    let onImagePicked: (UIImage) -> Void
    // ...
}
```

## 필요한 권한

Info.plist에 추가해야 할 권한:
- `NSLocationWhenInUseUsageDescription`
- `NSCameraUsageDescription`
- `NSPhotoLibraryUsageDescription`

## 구현된 기능

1. 지도 기능
   - 현재 위치 표시
   - 스팟 마커 표시
   - 지도 이동 및 확대/축소

2. 사진 기능
   - 카메라로 사진 촬영
   - 갤러리에서 사진 선택
   - 이미지 저장 및 로드

3. 위치 기능
   - 위치 권한 관리
   - 실시간 위치 업데이트
   - 좌표 기반 스팟 저장

## 참고사항

이 예제는 다음과 같은 iOS 프레임워크들을 활용합니다:
- MapKit
- CoreLocation
- UIKit (UIImagePickerController)
- PhotosUI
- SwiftUI

실제 프로덕션 앱에서 추가로 구현할 수 있는 기능들:
- 스팟 검색
- 카테고리 분류
- 사용자 간 공유
- 오프라인 캐싱
- 서버 동기화
