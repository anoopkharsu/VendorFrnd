//
//  LoginViewModel.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 02/12/24.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var loginModel = LoginModel()
    private let authService = AuthService()

    func getOtp() {
        guard  !loginModel.phoneNumber.isEmpty else {
            loginModel.error = SCToastMessage(message: "Phone number is required", type: .error)
            return
        }
        
        authService.getOTP(number: loginModel.phoneNumber) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.loginModel.error = SCToastMessage(message: error.localizedDescription, type: .error)
                } else {
                    self?.loginModel.error = SCToastMessage(message: "OTP sent successfully", type: .success)
                }
            }
        }
    }
}
