# Networking Example - Weather App

이 예제는 Swift에서 네트워킹을 구현하는 방법을 보여주는 간단한 날씨 앱입니다.

## 주요 학습 포인트

1. URLSession을 사용한 네트워크 요청
2. async/await를 활용한 비동기 프로그래밍
3. Codable 프로토콜을 사용한 JSON 파싱
4. 에러 핸들링
5. SwiftUI와 결합한 네트워크 데이터 표시

## 프로젝트 구조

- `WeatherModel.swift`: 데이터 모델과 네트워킹 서비스
- `WeatherView.swift`: 메인 UI 구현
- `WeatherApp.swift`: 앱 진입점

## 사용 방법

1. OpenWeatherMap API 키 발급
   - https://openweathermap.org 에서 회원가입
   - API 키 발급
   - `WeatherModel.swift`의 `apiKey` 변수에 발급받은 키 입력

2. 앱 실행
   - 도시 이름 입력
   - "날씨 검색" 버튼 클릭
   - 해당 도시의 현재 날씨 정보 확인

## 주요 기능

- 도시 이름으로 날씨 검색
- 현재 기온, 체감 온도, 습도 표시
- 에러 처리 및 로딩 상태 표시

## 참고사항

이 예제는 다음과 같은 현대적인 Swift 기능들을 활용합니다:
- Swift Concurrency (async/await)
- SwiftUI
- Codable 프로토콜
- 에러 핸들링
