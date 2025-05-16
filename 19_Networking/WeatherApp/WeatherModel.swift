import Foundation

struct WeatherResponse: Codable {
    let main: MainWeather
    let name: String
    
    struct MainWeather: Codable {
        let temp: Double
        let humidity: Int
        let feelsLike: Double
        
        enum CodingKeys: String, CodingKey {
            case temp
            case humidity
            case feelsLike = "feels_like"
        }
    }
}

class WeatherService {
    static let shared = WeatherService()
    private let apiKey = "YOUR_API_KEY" // OpenWeatherMap API 키를 여기에 입력하세요
    
    func fetchWeather(for city: String) async throws -> WeatherResponse {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(WeatherResponse.self, from: data)
    }
}
