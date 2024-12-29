//
//  PhoneNumberInputView.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 04/12/24.
//

import SwiftUI

struct PhoneNumberInputView: View {
    @Binding var selectedCountryCode: String // Default country code
    @Binding var phoneNumber: String
    @State private var isFocused: Bool = false
    
    let countryCodes = ["+1", "+44", "+91", "+61", "+81", "+86"] // List of country codes
    
    var body: some View {
        HStack {
            Menu {
                ForEach(countryCodes, id: \.self) { code in
                    Button(action: {
                        selectedCountryCode = code
                    }) {
                        Text(code)
                    }
                }
            } label: {
                Text(selectedCountryCode)
                    .foregroundColor(.blue)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 1)
            )
            
            TextField("login.enter.phone".localized, text: $phoneNumber, onEditingChanged: { focused in
                isFocused = focused
            })
            .textContentType(.telephoneNumber)
            .keyboardType(.phonePad)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isFocused ? Color.blue: .gray, lineWidth: 1)
            )
        }
        .padding()
    }
}

struct PhoneNumberFieldHelper: View {
    @State private var number = ""
    @State var countryCode: String = "+91"
    
    var body: some View {
        PhoneNumberInputView( selectedCountryCode: $countryCode, phoneNumber: $number)
    }
}
#Preview {
    PhoneNumberFieldHelper()
}
