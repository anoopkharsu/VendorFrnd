//
//  OTPVerificationViewModel.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 04/12/24.
//

import SwiftUI

enum OTPVerificationState {
    case idle
    case verifying
    case success
    case error
}


class OTPVerificationViewModel: ObservableObject {
    @Published var otpCode = ["","","","","",""]
    @Published var verificationState: OTPVerificationState = .idle
    
    @Published var presentToast: Bool = false
    @Published var toastMessage: SCToastMessage?

    private let authService = AuthService()

    func verifyOTP() {
        let code = otpCode.joined()
        guard !code.isEmpty else {
            verificationState = .error
            toastMessage = .init(message: "error.otp.required".localized, type: .error)
            return
        }
        
        verificationState = .verifying
        
        authService.verifyOTP(otpCode: code) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.verificationState = .error
                    self?.toastMessage = .init(message:"Invalid otp", type: .error)
                    self?.presentToast = true
                } else {
                    self?.verificationState = .success
                }
            }
        }
    }
}
