import SwiftUI

struct WeatherView: View {
    @State private var cityName = ""
    @State private var weather: WeatherResponse?
    @State private var errorMessage: String?
    @State private var isLoading = false
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("도시 이름을 입력하세요", text: $cityName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: fetchWeather) {
                Text("날씨 검색")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            if isLoading {
                ProgressView()
            } else if let weather = weather {
                WeatherInfoView(weather: weather)
            }
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
    }
    
    private func fetchWeather() {
        guard !cityName.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                weather = try await WeatherService.shared.fetchWeather(for: cityName)
            } catch {
                errorMessage = "날씨 정보를 가져오는데 실패했습니다: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }
}

struct WeatherInfoView: View {
    let weather: WeatherResponse
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("도시: \(weather.name)")
                .font(.title)
            
            Text("온도: \(String(format: "%.1f", weather.main.temp))°C")
            Text("체감 온도: \(String(format: "%.1f", weather.main.feelsLike))°C")
            Text("습도: \(weather.main.humidity)%")
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    WeatherView()
}
