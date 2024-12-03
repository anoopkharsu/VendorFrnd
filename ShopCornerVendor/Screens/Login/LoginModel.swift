//
//  LoginModel.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 02/12/24.
//

struct LoginModel {
    var isLoggedIn: Bool = false
    var error: SCToastMessage? = .init(message: "adfsdf", type: .error)
    var phoneNumber: String = ""
}
