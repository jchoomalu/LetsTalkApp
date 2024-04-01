import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var currentLocation: CLLocation?

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // Move the startUpdatingLocation call to the didChangeAuthorization delegate method
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            case .notDetermined:
                // Request permission if status has not been determined
                manager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                // Handle restricted or denied status
                break
            case .authorizedWhenInUse, .authorizedAlways:
                // Permission granted: start updating location
                manager.startUpdatingLocation()
            @unknown default:
                break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Update current location with the most recent location
        self.currentLocation = locations.last
    }

    // Add this to manually check authorization status and request permission if needed
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                // Handle restricted or denied status
                break
            case .authorizedWhenInUse, .authorizedAlways:
                // Permission granted: you might want to start updating location here as well
                locationManager.startUpdatingLocation()
            @unknown default:
                break
        }
    }
}
