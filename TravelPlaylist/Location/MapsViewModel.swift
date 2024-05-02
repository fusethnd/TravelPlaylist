//
//  MapViewModel.swift
//  TravelPlaylist
//
//  Created by Thanapat on 23/4/2567 BE.
//

import Foundation
import MapKit

class MapsViewModel: ObservableObject {
    
    // Fix Location
    // Change Default to current Location
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    @Published var annotations: [AnnotationItem] = []
    
    func addAnnotation(coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil) {
        let annotation = AnnotationItem(coordinate: coordinate, title: title, subtitle: subtitle)
        annotations.append(annotation)
    }
}

struct AnnotationItem: Identifiable {
    
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
}
