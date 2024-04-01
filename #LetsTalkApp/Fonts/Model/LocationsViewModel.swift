import Foundation
import CoreLocation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
import CoreLocation
import MapKit

class LocationsViewModel: ObservableObject {
    struct Place: Identifiable, Decodable {
        @DocumentID var id: String?
        var name: String
        var latitude: Double
        var longitude: Double
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case latitude
            case longitude
        }
        
        var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decodeIfPresent(String.self, forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)
            self.latitude = try container.decode(Double.self, forKey: .latitude)
            self.longitude = try container.decode(Double.self, forKey: .longitude)
        }
    }
    
    @Published var places: [Place] = []
    @Published var region = MKCoordinateRegion()
    private var locationManager = LocationManager()
    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        locationManager.$currentLocation
            .compactMap { $0 }
            .first()
            .sink { [weak self] location in
                // Instead of directly updating the state, call a method that does this.
                self?.processNewLocation(location)
            }
            .store(in: &cancellables)
    }
    
    private func processNewLocation(_ location: CLLocation) {
        // Now this method can safely update the state as it's decoupled from the view updates.
        updateRegion(with: location)
        fetchNearbyPlaces(userLocation: location)
    }
    
    private func updateRegion(with location: CLLocation) {
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        }
    }
    
    private func fetchNearbyPlaces(userLocation: CLLocation) {
        db.collection("locations").getDocuments { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            let fetchedPlaces = documents.compactMap { queryDocumentSnapshot -> Place? in
                try? queryDocumentSnapshot.data(as: Place.self)
            }
            DispatchQueue.main.async {
                self.places = fetchedPlaces
                print(fetchedPlaces)
            }
        }
    }
}
