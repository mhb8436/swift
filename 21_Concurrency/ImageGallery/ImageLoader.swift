import Foundation
import SwiftUI

actor ImageLoader {
    private var cache: [URL: Image] = [:]
    private let session = URLSession.shared
    
    func loadImage(from url: URL) async throws -> Image {
        if let cachedImage = cache[url] {
            return cachedImage
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("[회신] URL: \(url)")
                print("[회신] Status Code: \(httpResponse.statusCode)")
                print("[회신] Headers: \(httpResponse.allHeaderFields)")
            }
            
            guard let uiImage = UIImage(data: data) else {
                print("[에러] 이미지 데이터 변환 실패. 데이터 크기: \(data.count) bytes")
                throw URLError(.cannotDecodeRawData)
            }
            let image = Image(uiImage: uiImage)
            cache[url] = image
            return image
        } catch {
            print("[에러] URL: \(url)")
            print("[에러] 상세 내용: \(error.localizedDescription)")
            if let urlError = error as? URLError {
                print("[에러] URLError 코드: \(urlError.code.rawValue)")
                print("[에러] URLError 설명: \(urlError.localizedDescription)")
            }
            throw error
        }
    }
    
    func clearCache() {
        cache.removeAll()
    }
}

@MainActor
class ImageViewModel: ObservableObject {
    private let imageLoader = ImageLoader()
    @Published var images: [URL: Image] = [:]
    @Published var isLoading = false
    @Published var error: Error?
    
    private let urls = [
        URL(string: "https://images.unsplash.com/photo-1682687220742-aba13b6e50ba?w=300&h=300&fit=crop")!,
        URL(string: "https://images.unsplash.com/photo-1682687220063-4742bd7fd538?w=300&h=300&fit=crop")!,
        URL(string: "https://images.unsplash.com/photo-1682687220067-dced84a2941b?w=300&h=300&fit=crop")!,
        URL(string: "https://images.unsplash.com/photo-1682687220208-16c2d06731c6?w=300&h=300&fit=crop")!,
        URL(string: "https://images.unsplash.com/photo-1682687220923-c58b9a4592ae?w=300&h=300&fit=crop")!,
        URL(string: "https://images.unsplash.com/photo-1682687220945-502d9a73165b?w=300&h=300&fit=crop")
    ]
    
    func loadImages() {
        isLoading = true
        error = nil
        
        // 이전 작업들을 취소하기 위해 새로운 Task 시작 전에 images 초기화
        images.removeAll()
        
        Task {
            do {
                // 한 번에 하나씩 순차적으로 로드
                for url in urls {
                    do {
                        let image = try await self.imageLoader.loadImage(from: url)
                        self.images[url] = image
                    } catch {
                        print("[이미지 로드 실패] \(url): \(error.localizedDescription)")
                        // 개별 이미지 실패는 무시하고 계속 진행
                        continue
                    }
                }
                isLoading = false
            } catch {
                self.error = error
                isLoading = false
            }
        }
    }
    
    func reloadImages() {
        images.removeAll()
        Task {
            await imageLoader.clearCache()
            loadImages()
        }
    }
}
