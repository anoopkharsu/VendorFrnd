//
//  LocationManager.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 24/12/24.
//


import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()

    @Published var location: CLLocation? = nil
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var error: SCToastMessage? = nil
    @Published var isUpdating: Bool = false
    @Published var showError: Bool = false
    
    
    let repository = SettingsRepository()
    
    override init() {
        super.init()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
    }
    
    func setLocation(location: CLLocationCoordinate2D) {
        self.location = CLLocation(latitude: location.latitude, longitude: location.longitude)
    }
    
    func updateVendorLocation(callback: @escaping () -> Void) {
        self.isUpdating = true
        let vendorId = AuthService.shared.getVendor().id
        if let lat = self.location?.coordinate.latitude,
           let lng = self.location?.coordinate.longitude {
            //                https://maps.google.com/?q=28.502035,77.044670
            self.repository.updateVendorLocation(.init(vendor_id: vendorId, latitude:lat, longitude: lng)) {[weak self] _, error in
                self?.isUpdating = false
                if let error {
                    self?.showError = true
                    self?.error = .init(message: error.localizedDescription, type: .error)
                }
                callback()
            }
        } else {
            self.showError = true
            self.error = .init(message: "Location not available", type: .error)
        }
        
    }

    // CLLocationManagerDelegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.location = location
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.showError = true
            self.error = .init(message: error.localizedDescription, type: .error)
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        DispatchQueue.main.async {
            self.authorizationStatus = status
            if status == .authorizedWhenInUse || status == .authorizedAlways {
                self.locationManager.startUpdatingLocation()
            } else {
                self.locationManager.stopUpdatingLocation()
            }
        }
    }
    
    
}
struct SCVendorLocation: Codable {
    var vendor_id: Int
    var latitude, longitude: Double
}
