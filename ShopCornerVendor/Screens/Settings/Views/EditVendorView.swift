//
//  EditVendorView.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 07/12/24.
//

import SwiftUI

struct EditVendorView: View {
    @Environment(\.presentationMode) var presentationMode
    let vendor: SCVendor
    @State private var email: String
    @State private var shopName: String
    @State private var address: String
    @State private var ownerName: String
    
    let saveCallback: (SCVendor) -> Void
    
    init(vendor: SCVendor, saveCallback: @escaping (SCVendor) -> Void) {
        self.saveCallback = saveCallback
        self.vendor = vendor
        _email = State(initialValue: vendor.email ?? "")
        _shopName = State(initialValue: vendor.shop_name ?? "")
        _address = State(initialValue: vendor.address ?? "")
        _ownerName = State(initialValue: vendor.owner_name ?? "")
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                }
                Spacer()
                Text("Edit Details")
                    .font(.headline)
                    .padding()
                Spacer()
                Button {
                    saveChanges()
                } label: {
                    Text("Save")
                }
            }
            .padding(.horizontal)
            List {
                CutstomTextField(title: "Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                
                CutstomTextField(title: "Shop Name", text: $shopName)
                    .autocapitalization(.words)
                
                CutstomTextField(title: "Owner Name", text: $ownerName)
                    .autocapitalization(.words)
                
                CutstomTextEditor( title: "Address", text: $address)
                    .frame(minHeight: 80)
                
            }
            .listRowSeparator(.hidden)
            .listStyle(.plain)
        }
    }
    
    
    private func isValidEmail(_ email: String) -> Bool {
        // Basic email validation regex
        let emailRegEx = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    
    private func saveChanges() {
        // Validate form before saving
        
        
        // Create an updated SCVendor object
        var updatedVendor = self.vendor
        updatedVendor.email = email
        updatedVendor.shop_name = shopName
        updatedVendor.address = address
        updatedVendor.owner_name = ownerName
        
        // Update via ViewModel
        
        saveCallback(updatedVendor)
    }
    
}

struct CutstomTextEditor: View {
    let title: String?
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let title {
                Text(title)
                    .font(.footnote)
                    .padding(.leading,8)
                    .foregroundStyle(.secondary)
            }
            TextEditor( text: $text)
                .frame(minHeight: 80)
                .padding(.all,8)
                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).foregroundStyle(.gray.opacity(0.5)))
                
        }
        .listRowSeparator(.hidden)
        .listRowInsets(.init(top: 12, leading: 12, bottom: 8, trailing: 12))
    }
}

struct CutstomTextField: View {
    let title: String?
    let placeholder: String
    @Binding var text: String
    
    init(title: String?, placeholder: String = "", text: Binding<String>) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let title {
                Text(title)
                    .font(.footnote)
                    .padding(.leading,8)
                    .foregroundStyle(.secondary)
            }
            TextField(placeholder, text: $text)
                .padding(.all,8)
                .background(.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .listRowSeparator(.hidden)
        .listRowInsets(.init(top: 12, leading: 12, bottom: 8, trailing: 12))
    }
}
