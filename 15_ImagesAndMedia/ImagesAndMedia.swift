import SwiftUI
import AVKit

// 기본 이미지 (React의 img와 유사)
// React: <img src={imageUrl} alt="description" />
struct BasicImage: View {
    var body: some View {
        VStack(spacing: 20) {
            // 시스템 이미지
            Image(systemName: "star.fill")
                .font(.system(size: 50))
                .foregroundColor(.yellow)
            
            // 로컬 이미지
            Image("example_image") // 이미지 에셋에 추가 필요
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            // 원격 이미지
            AsyncImage(url: URL(string: "https://example.com/image.jpg")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(height: 200)
        }
        .padding()
        .navigationTitle("Basic Images")
    }
}

// 이미지 갤러리 (React의 이미지 갤러리 컴포넌트와 유사)
// React: <div className="gallery">{images.map(img => <img key={img.id} src={img.url} />)}</div>
struct ImageGallery: View {
    let images = [
        "image1", "image2", "image3", "image4", "image5", "image6"
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(images, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 120)
                        .clipped()
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationTitle("Image Gallery")
    }
}

// 이미지 편집 (React의 이미지 편집 컴포넌트와 유사)
// React: <ImageEditor image={image} onEdit={handleEdit} />
struct ImageEditor: View {
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Double = 0
    @State private var brightness: Double = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Image("example_image")
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .scaleEffect(scale)
                .rotationEffect(.degrees(rotation))
                .brightness(brightness)
            
            VStack(spacing: 15) {
                HStack {
                    Text("Scale")
                    Slider(value: $scale, in: 0.5...2.0)
                }
                
                HStack {
                    Text("Rotation")
                    Slider(value: $rotation, in: 0...360)
                }
                
                HStack {
                    Text("Brightness")
                    Slider(value: $brightness, in: -0.5...0.5)
                }
            }
            .padding()
        }
        .navigationTitle("Image Editor")
    }
}

// 비디오 플레이어 (React의 video와 유사)
// React: <video src={videoUrl} controls />
struct VideoPlayer: View {
    let videoURL = URL(string: "https://example.com/video.mp4")!
    
    var body: some View {
        VStack {
            VideoPlayer(player: AVPlayer(url: videoURL))
                .frame(height: 300)
            
            Text("Video Player")
                .font(.headline)
                .padding()
        }
        .navigationTitle("Video Player")
    }
}

// 미디어 그리드 (React의 미디어 그리드 컴포넌트와 유사)
// React: <MediaGrid items={mediaItems} />
struct MediaGrid: View {
    struct MediaItem: Identifiable {
        let id = UUID()
        let type: MediaType
        let url: URL
    }
    
    enum MediaType {
        case image
        case video
    }
    
    let items = [
        MediaItem(type: .image, url: URL(string: "https://example.com/image1.jpg")!),
        MediaItem(type: .video, url: URL(string: "https://example.com/video1.mp4")!),
        MediaItem(type: .image, url: URL(string: "https://example.com/image2.jpg")!),
        MediaItem(type: .video, url: URL(string: "https://example.com/video2.mp4")!)
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(items) { item in
                    switch item.type {
                    case .image:
                        AsyncImage(url: item.url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                            case .failure:
                                Image(systemName: "photo")
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(10)
                        
                    case .video:
                        VideoPlayer(player: AVPlayer(url: item.url))
                            .frame(height: 200)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Media Grid")
    }
}

// 프리뷰
struct ImagesAndMedia_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Group {
                BasicImage()
                ImageGallery()
                ImageEditor()
                VideoPlayer()
                MediaGrid()
            }
        }
    }
} 