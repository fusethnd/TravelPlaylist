//
//  MapView.swift
//  TravelPlaylist
//
//  Created by Thanapat on 23/4/2567 BE.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: .none, annotationItems: viewModel.annotations) { annotation in
            MapMarker(coordinate: annotation.coordinate, tint: .red)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            // Call the method to add existing points here
            addExistingPoints()
        }
    }
    
    private func addExistingPoints() {
        // Check if location services are enabled
        guard CLLocationManager.locationServicesEnabled() else {
            print("Location services are not enabled.")
            return
        }
        
        // Request authorization for location services
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        // Get the user's current location
        if let userLocation = locationManager.location {
            viewModel.addAnnotation(coordinate: userLocation.coordinate, title: "Current Location")
        } else {
            print("Unable to get the user's current location.")
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}