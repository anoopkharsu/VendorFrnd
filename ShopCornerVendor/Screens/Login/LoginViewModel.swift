//
//  LoginViewModel.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 02/12/24.
//

import SwiftUI

enum ScreenState {
    case idle
    case showActivityIndicator
    
}

class LoginViewModel: ObservableObject {
    @Published var loginModel = LoginModel()
    @Published var presentToast = false
    @Published var navigateToOTPVerification = false
    @Published var screenState: ScreenState = .idle
    
    private let authService = AuthService()

    func getOtp() {
        guard !loginModel.phoneNumber.isEmpty else {
            loginModel.error = SCToastMessage(
                message: "error.phone.required".localized,
                type: .error
            )
            presentToast = true
            return
        }
        self.screenState = .showActivityIndicator
        
        authService.getOTP(number: loginModel.countryCode + loginModel.phoneNumber) { [weak self] error in
            DispatchQueue.main.async {
                self?.screenState = .idle
                if let error = error {
                    self?.loginModel.error = SCToastMessage(
                        message: error.localizedDescription,
                        type: .error
                    )
                } else {
                    self?.loginModel.error = SCToastMessage(
                        message: "success.otp.sent".localized,
                        type: .success
                    )
                    // OTP sent successfully
                    self?.navigateToOTPVerification = true // Trigger navigation
                }
                self?.presentToast = true
            }
        }
    }
}
