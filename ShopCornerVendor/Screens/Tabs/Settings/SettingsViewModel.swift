//
//  SettingsViewModel.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 07/12/24.
//
import SwiftUI
import Combine
import CoreLocation

// MARK: - SettingsViewModel

class SettingsViewModel: ObservableObject {
    // MARK: - Private Properties
    private let repository: SettingsRepository
    private let phoneNumber: String
    
    // MARK: - Published Properties
    @Published var vendor: SCVendor
    @Published var errorMessage: SCToastMessage?
    @Published var showError = false
    @Published var isLoading: Bool = false
    @Published var locationDetails = ""
    
    // MARK: - Initializer
    init(phoneNumber: String, repository: SettingsRepository = SettingsRepository()) {
        self.phoneNumber = phoneNumber
        self.repository = repository
        self.vendor = .init(id: -1, phone_number: phoneNumber)
    }
    
    // MARK: - Public Methods
    
    /// Loads vendor details based on the phone number.
    func loadVendor() {
        isLoading = true
        repository.getVendorDetails(phoneNumber) { [weak self] vendor, error in
            guard let self = self else { return }
            self.isLoading = false
            if let error = error {
                self.showError(message: error.localizedDescription)
            } else {
                if let vendor {
                    self.vendor = vendor
                    if let lng = vendor.longitude, let lat = vendor.latitude {
                        self.fetchLocationDetails(from: .init(latitude: lat, longitude: lng))
                    }
                }
            }
        }
    }
    
    /// Uploads an image and updates the vendor's photo.
    /// - Parameter image: The `UIImage` to upload.
    func uploadImage(_ image: UIImage) {
        guard let imageData = image.resized() else {
            showError(message: "Failed to convert image to data.")
            return
        }
        
        isLoading = true
        let uploadRequest = SettingsModels.UploadImage.Request(fileName: "profile.jpg", fileType: "image/jpeg")
        
        repository.getuploadURL(.uploadImage(request: uploadRequest)) { [weak self] uploadData, error in
            guard let self = self else { return }
            
            if let error = error {
                self.isLoading = false
                self.showError(message: error.localizedDescription)
                return
            }
            
            guard let uploadData = uploadData,
                  let uploadURL = URL(string: uploadData.uploadUrl) else {
                self.isLoading = false
                self.showError(message: "Invalid upload URL.")
                return
            }
            
            SCNetwork.shared.uploadImage(to: uploadURL, imageData: imageData) { uploadError in
                if let uploadError = uploadError {
                    self.isLoading = false
                    self.showError(message: uploadError.localizedDescription)
                } else {
                    self.updateVendorPhoto(with: uploadData.fileKey)
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    /// Updates the vendor's photo with the provided file key.
    /// - Parameter fileKey: The file key returned after uploading the image.
    private func updateVendorPhoto(with fileKey: String) {
        var currentVendor = vendor
        
        currentVendor.photo = fileKey
        updateVendor(currentVendor)
    }
    
    func updateVendor(_ vendor: SCVendor) {
        isLoading = true
        repository.updateVendor(.updateVenderDetails(request: vendor)) { [weak self] updatedVendor, error in
            guard let self = self else { return }
            self.isLoading = false
            if let error = error {
                self.showError(message: error.localizedDescription)
            } else if let updatedVendor = updatedVendor {
                self.vendor = updatedVendor
            } else {
                self.showError(message: "Failed to update vendor details.")
            }
        }
    }
    
    /// Displays an error message.
    /// - Parameter message: The error message to display.
    private func showError(message: String) {
        self.errorMessage = SCToastMessage(message: message, type: .error)
        self.showError = true
    }
    
    func fetchLocationDetails(from location: CLLocation) {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Error in reverse geocoding: \(error)")
                return
            }
            
            if let placemark = placemarks?.first {
//                print("Placemark: \(placemark)")
                let locality = placemark.locality ?? "N/A"
                let administrativeArea = placemark.administrativeArea ?? "N/A"
                let country = placemark.country ?? "N/A"
                let postalCode = placemark.postalCode ?? "N/A"
                let subLocality = placemark.subLocality ?? "N/A"
                let thoroughfare = placemark.thoroughfare ?? "N/A"
                let subThoroughfare = placemark.subThoroughfare ?? "N/A"
                
                print("""
                        Locality: \(locality)
                        Administrative Area: \(administrativeArea)
                        Country: \(country)
                        Postal Code: \(postalCode)
                        SubLocality: \(subLocality)
                        Thoroughfare: \(thoroughfare)
                        SubThoroughfare: \(subThoroughfare)
                        """)
                DispatchQueue.main.async {
                    self.locationDetails = "\(thoroughfare) \(subLocality) \(locality), \(postalCode) \(administrativeArea), \(country)"
                }
            }
        }
    }
}
