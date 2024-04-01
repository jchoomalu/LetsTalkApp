import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    var places: [LocationsViewModel.Place]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
        updateAnnotations(from: uiView)
    }
    
    private func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        let annotations = places.map { place -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.title = place.name
            annotation.coordinate = place.coordinate
            return annotation
        }
        mapView.addAnnotations(annotations)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // Coordinator class for handling MKMapViewDelegate methods.
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ mapView: MapView) {
            self.parent = mapView
        }
    }
}

// MARK: - Map

struct Map: View {
    @StateObject private var viewModel = LocationsViewModel()
       
    var body: some View {
        MapView(region: $viewModel.region, places: viewModel.places)
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    Map()
}
