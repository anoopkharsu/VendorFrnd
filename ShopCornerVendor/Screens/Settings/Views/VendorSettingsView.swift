//
//  VendorSettingsView.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 07/12/24.
//
import SwiftUI

struct VendorSettingsView: View {
    @StateObject var viewModel: SettingsViewModel
    @State private var isEditing = false
    @State private var latLong: (Double,Double)? = nil
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        List {
            profileSection
            contactDetailsSection
            
            QRCodeView(urlString: "shopcorner://vendor?id=\(viewModel.vendor.id)")
        }
        .listStyle(.insetGrouped)
        .toast(isPresented: self.$viewModel.showError, message: self.viewModel.errorMessage)
        .toast(isPresented: self.$locationManager.showError, message: self.locationManager.error)
        .loading(isLoading: self.viewModel.isLoading || self.locationManager.isUpdating)
        .sheet(isPresented: $isEditing) {
            EditVendorView(vendor: viewModel.vendor, saveCallback: { updatedVendor in
                self.isEditing = false
                self.viewModel.updateVendor(updatedVendor)
            })
        }
        .onAppear {
            self.viewModel.loadVendor()
        }
    }
    
    
    // MARK: - Sections
    
    /// Profile Section containing the vendor's profile image and shop name with an edit button.
    private var profileSection: some View {
        Section {
            HStack(spacing: 16) {
                // Profile Image with Image Picker
                ImagePickerView(
                    content: {
                        AsyncImage(url: URL(string: viewModel.vendor.image_url ?? "")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            // Placeholder while loading the image
                            Color.gray
                        }
                        
                        
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    },
                    onImageSelected: { image in
                        viewModel.uploadImage(image)
                    }
                )
                
                // Shop Name and Edit Button
                HStack(alignment: .center) {
                    Text(viewModel.vendor.shop_name ?? "Your Shop")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                }
            }
        } footer: {
            Text("Set up your profile to share your products")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
    @State var pickLocation: Bool = false
    /// Contact Details Section displaying phone number, address, and owner name with an edit button.
    private var contactDetailsSection: some View {
        Section {
            DetailRow(title: "Phone Number", value: viewModel.vendor.phone_number)
            
            DetailRow(title: "Address", value: viewModel.vendor.address ?? "N/A")
            
            if let ownerName = viewModel.vendor.owner_name {
                DetailRow(title: "Owner Name", value: ownerName)
            }
            
            Button {
                
                pickLocation = true
                //
            } label: {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Tap To Update Shop Loction")
                        Spacer()
                        Image(systemName: "mappin.and.ellipse")
                    }
                    if !viewModel.locationDetails.isEmpty {
                        Text(viewModel.locationDetails)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    } else {
                        Text("This will help nearby customers find you")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
            }
            .sheet(isPresented: $pickLocation) {
                PickLocationView { location in
                    self.pickLocation = false
                    self.locationManager.setLocation(location: location)
                    locationManager.updateVendorLocation(callback: {
                        self.viewModel.loadVendor()
                    })
                }
            }
        } footer: {
            HStack {
                Spacer()
                
                Button(action: {
                    isEditing = true
                }) {
                    Text("Edit Details")
                        .font(.footnote)
                        .foregroundColor(.blue)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

/// A reusable view for displaying a title-value pair in a row.
struct DetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.footnote)
                .foregroundColor(.secondary)
            Text(value)
            //                .padding(.leading,8)
                .foregroundColor(.primary)
        }
        //        .listRowSeparator(.hidden)
        //        .padding(.vertical, 4)
    }
}



