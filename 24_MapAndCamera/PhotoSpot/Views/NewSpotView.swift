import SwiftUI
import CoreLocation
import PhotosUI

struct NewSpotView: View {
    let coordinate: CLLocationCoordinate2D
    let onSave: (String, String, UIImage) -> Void
    
    @State private var title = ""
    @State private var description = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var isShowingCamera = false
    @State private var sourceType: UIImagePickerController.SourceType?
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("제목", text: $title)
                    TextField("설명", text: $description)
                }
                
                Section {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                    
                    HStack {
                        Button("카메라") {
                            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                                sourceType = .camera
                            }
                        }
                        .disabled(!UIImagePickerController.isSourceTypeAvailable(.camera))
                        
                        Divider()
                        
                        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                            PhotosPicker(selection: $selectedItem, matching: .images) {
                                Text("갤러리")
                            }
                        }
                    }
                }
                
                Section {
                    Text("위치: \(String(format: "%.6f", coordinate.latitude)), \(String(format: "%.6f", coordinate.longitude))")
                        .font(.caption)
                }
            }
            .navigationTitle("새로운 스팟")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("저장") {
                        if let image = selectedImage {
                            onSave(title, description, image)
                        }
                    }
                    .disabled(title.isEmpty || selectedImage == nil)
                }
            }
            .onChange(of: selectedItem) { _ in
                Task {
                    if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        selectedImage = image
                    }
                }
            }
            .sheet(isPresented: .constant(sourceType != nil)) {
                sourceType = nil
            } content: {
                if let sourceType = sourceType {
                    ImagePicker(sourceType: sourceType) { image in
                        selectedImage = image
                        self.sourceType = nil
                    }
                }
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    let sourceType: UIImagePickerController.SourceType
    let onImagePicked: (UIImage) -> Void
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onImagePicked: onImagePicked)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let onImagePicked: (UIImage) -> Void
        
        init(onImagePicked: @escaping (UIImage) -> Void) {
            self.onImagePicked = onImagePicked
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                onImagePicked(image)
            }
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}
