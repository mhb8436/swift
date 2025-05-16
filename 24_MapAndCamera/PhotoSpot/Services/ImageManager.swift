import UIKit
import Photos

enum ImageError: Error {
    case saveFailed
    case loadFailed
    case permissionDenied
}

class ImageManager {
    static let shared = ImageManager()
    private let fileManager = FileManager.default
    
    private init() {}
    
    func saveImage(_ image: UIImage, withName name: String) throws -> String {
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            throw ImageError.saveFailed
        }
        
        let documentsDirectory = try fileManager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        
        let fileName = "\(name)_\(UUID().uuidString).jpg"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        try data.write(to: fileURL)
        return fileName
    }
    
    func loadImage(fileName: String) throws -> UIImage {
        let documentsDirectory = try fileManager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = try? Data(contentsOf: fileURL),
              let image = UIImage(data: data) else {
            throw ImageError.loadFailed
        }
        
        return image
    }
    
    func checkPhotoLibraryPermission() async -> Bool {
        let status = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
        return status == .authorized
    }
}
