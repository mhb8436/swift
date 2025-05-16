import Foundation
import SwiftUI

actor ImageLoader {
    private var cache: [URL: Image] = [:]
    
    func loadImage(from url: URL) async throws -> Image {
        if let cachedImage = cache[url] {
            return cachedImage
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let uiImage = UIImage(data: data) else {
            throw URLError(.badServerResponse)
        }
        
        let image = Image(uiImage: uiImage)
        cache[url] = image
        return image
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
        URL(string: "https://picsum.photos/id/1/300/300")!,
        URL(string: "https://picsum.photos/id/2/300/300")!,
        URL(string: "https://picsum.photos/id/3/300/300")!,
        URL(string: "https://picsum.photos/id/4/300/300")!,
        URL(string: "https://picsum.photos/id/5/300/300")!,
        URL(string: "https://picsum.photos/id/6/300/300")!
    ]
    
    func loadImages() {
        isLoading = true
        error = nil
        
        Task {
            do {
                try await withThrowingTaskGroup(of: (URL, Image).self) { group in
                    for url in urls {
                        group.addTask {
                            let image = try await self.imageLoader.loadImage(from: url)
                            return (url, image)
                        }
                    }
                    
                    for try await (url, image) in group {
                        self.images[url] = image
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
