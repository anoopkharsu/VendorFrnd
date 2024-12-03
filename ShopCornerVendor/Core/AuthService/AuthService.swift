//
//  AuthService.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 02/12/24.
//

import FirebaseAuth

class AuthService {
    static let authVerificationIDKey = "authVerificationID"
    static let shared = AuthService()
    
    var isUserLoggedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    func getOTP(number: String, callback: @escaping (Error?) -> Void) {
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(number) { verificationID, error in
                if let verificationID {
                    UserDefaults.standard.set(verificationID, forKey: AuthService.authVerificationIDKey)
                    callback(nil)
                } else {
                    callback(error)
                }
            }
    }
    
}
