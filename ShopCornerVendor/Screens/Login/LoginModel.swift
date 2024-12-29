//
//  LoginModel.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 02/12/24.
//

struct LoginModel {
    var isLoggedIn: Bool = false
    var error: SCToastMessage?
    var phoneNumber: String = "" {
        didSet {
            checkPhoneNumberCountryCode()
        }
    }
    var countryCode: String = "+91"
    
    mutating func checkPhoneNumberCountryCode() {
        if phoneNumber.hasPrefix(countryCode) {
            phoneNumber.removeFirst(countryCode.count)
        }
    }
}
