import SwiftUI

struct GalleryView: View {
    @StateObject private var viewModel = ImageViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(Array(viewModel.images.keys), id: \.self) { url in
                            if let image = viewModel.images[url] {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    .padding()
                }
                
                if viewModel.isLoading {
                    ProgressView("이미지 로딩 중...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding()
                }
            }
            .navigationTitle("이미지 갤러리")
            .toolbar {
                Button(action: viewModel.reloadImages) {
                    Image(systemName: "arrow.clockwise")
                }
            }
            .alert("에러", isPresented: .constant(viewModel.error != nil)) {
                Button("확인") {
                    viewModel.error = nil
                }
            } message: {
                Text(viewModel.error?.localizedDescription ?? "알 수 없는 에러가 발생했습니다.")
            }
        }
        .onAppear {
            viewModel.loadImages()
        }
    }
}
