//
//  MapView.swift
//  TravelPlaylist
//
//  Created by Thanapat on 23/4/2567 BE.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapsView: View {
    @StateObject private var viewModel = MapsViewModel()
    
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
    
    // Add current location
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

struct MapsView_Previews: PreviewProvider {
    static var previews: some View {
        MapsView()
    }
}
