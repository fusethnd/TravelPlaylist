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
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    let latitude: Double
    let longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var body: some View {
        VStack {
            Map(position: $position) {
                Marker("Location", coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
//                MapCircle(center: CLLocationCoordinate2D(latitude: latitude, longitude: latitude), radius: 500)
//                    .foregroundStyle(.red.opacity(0.2))
              
            }
            .onAppear {
                CLLocationManager().requestWhenInUseAuthorization()
                if let userCoordinate = locationManager.userCoordinate {
                    let region = MKCoordinateRegion(center: userCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
                    cameraPosition = .region(region)
                }
            }
        }
    }
}




//Map(position: $cameraPosition){
//    Marker("Location", coordinate: CLLocationCoordinate2DMake(48.856788, 2.351077))
//}
//    .onAppear{
//        let paris = CLLocationCoordinate2D(latitude: 48.856788, longitude: 2.351077)
//        let parisSpan = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
//        let parisRegion = MKCoordinateRegion(center: paris, span: parisSpan)
//        cameraPosition = .region(parisRegion)
//    }
