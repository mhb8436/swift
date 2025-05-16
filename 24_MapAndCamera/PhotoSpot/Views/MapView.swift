import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = PhotoSpotViewModel()
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        NavigationView {
            Map(
                coordinateRegion: $viewModel.region,
                showsUserLocation: true,
                annotationItems: viewModel.spots
            ) { spot in
                MapAnnotation(coordinate: spot.coordinate) {
                    SpotAnnotationView(spot: spot)
                        .onTapGesture {
                            viewModel.selectedSpot = spot
                        }
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .sheet(item: $viewModel.selectedSpot) { spot in
                SpotDetailView(spot: spot, image: viewModel.loadImage(for: spot))
            }
            .sheet(isPresented: $viewModel.isShowingNewSpot) {
                if let location = locationManager.location {
                    NewSpotView(
                        coordinate: location.coordinate,
                        onSave: { title, description, image in
                            viewModel.addPhotoSpot(
                                title: title,
                                description: description,
                                image: image,
                                coordinate: location.coordinate
                            )
                            viewModel.isShowingNewSpot = false
                        }
                    )
                }
            }
            .navigationTitle("포토 스팟")
            .toolbar {
                Button(action: { viewModel.isShowingNewSpot = true }) {
                    Image(systemName: "plus")
                }
                .disabled(locationManager.location == nil)
            }
            .alert("오류", isPresented: .constant(viewModel.error != nil)) {
                Button("확인") {
                    viewModel.error = nil
                }
            } message: {
                Text(viewModel.error?.localizedDescription ?? "알 수 없는 오류가 발생했습니다.")
            }
        }
        .onAppear {
            locationManager.requestLocationPermission()
        }
    }
}

struct SpotAnnotationView: View {
    let spot: PhotoSpot
    
    var body: some View {
        VStack {
            Image(systemName: "camera.fill")
                .foregroundColor(.white)
                .padding(8)
                .background(Color.blue)
                .clipShape(Circle())
            
            Text(spot.title)
                .font(.caption)
                .padding(4)
                .background(Color.white)
                .cornerRadius(4)
        }
    }
}
