//
//  GoogleMapView.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 16/02/25.
//


//
//  GoogleMapView.swift
//  ShopCorner
//
//  Created by Anoop Kharsu on 05/01/25.
//

import SwiftUI
import GoogleMaps
import CoreLocation

// MARK: - GoogleMapView Representable
// This wraps a GMSMapView so we can use it in SwiftUI

struct GoogleMapView: UIViewRepresentable {
    // Binding to sync the center coordinate with SwiftUI
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var zoomLevel: Float

    func makeUIView(context: Context) -> GMSMapView {
        
        let camera = GMSCameraPosition.camera(withLatitude: centerCoordinate.latitude,
                                              longitude: centerCoordinate.longitude,
                                              zoom: zoomLevel)
        let mapView = GMSMapView(frame: .zero, camera: camera)
        
        // Optional settings
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = false
        mapView.settings.myLocationButton = true
        mapView.delegate = context.coordinator
        
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        // If SwiftUI’s centerCoordinate or zoom changes, update camera
        let updatedCamera = GMSCameraPosition.camera(withLatitude: centerCoordinate.latitude,
                                                     longitude: centerCoordinate.longitude,
                                                     zoom: zoomLevel)
        uiView.animate(to: updatedCamera)
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(self)
    }
    
    // MARK: - Coordinator
    class MapCoordinator: NSObject, GMSMapViewDelegate {
        var parent: GoogleMapView
        
        init(_ parent: GoogleMapView) {
            self.parent = parent
        }
        
        // Called when map dragging/zooming ends
        func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            // Update SwiftUI state
            parent.centerCoordinate = position.target
            print(position.target)
            parent.zoomLevel = position.zoom
        }
    }
}

