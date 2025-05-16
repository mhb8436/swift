import SwiftUI

struct SpotDetailView: View {
    let spot: PhotoSpot
    let image: UIImage?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(spot.title)
                            .font(.title)
                        
                        Text(spot.description)
                            .foregroundColor(.secondary)
                        
                        Text("촬영 날짜: \(spot.createdAt.formatted())")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("위치: \(String(format: "%.6f", spot.latitude)), \(String(format: "%.6f", spot.longitude))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
            }
            .navigationTitle("스팟 상세")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("닫기") {
                        dismiss()
                    }
                }
            }
        }
    }
}
