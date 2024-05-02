//
//  MapsView.swift
//  MapView
//
//  Created by Thanadon Boontawee on 2/5/2567 BE.
//

import SwiftUI
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var userCoordinate: CLLocationCoordinate2D?

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userCoordinate = location.coordinate
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

struct MapsView: View {
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            Map(
                coordinateRegion: .constant(
                    MKCoordinateRegion(
                        center: locationManager.userCoordinate ?? CLLocationCoordinate2D(latitude: 48.856788, longitude: 2.351077),
                        span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
                    )
                ),
                showsUserLocation: true
            )
            .frame(height: 300)
            
            if let userCoordinate = locationManager.userCoordinate {
                Text("Latitude: \(userCoordinate.latitude)")
                Text("Longitude: \(userCoordinate.longitude)")
            } else {
                Text("Latitude: -")
                Text("Longitude: -")
            }
        }
    }
