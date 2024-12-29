//
//  AuthService.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 02/12/24.
//

import FirebaseAuth

class AuthService {
    static let authVerificationIDKey = "authVerificationID"
    static let venderKey = "vendor"
    
    static let shared = AuthService()
    var phoneNumber: String? { Auth.auth().currentUser?.phoneNumber }
    var isUserLoggedIn: Bool {
        //        try? Auth.auth().signOut()
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
    
    func verifyOTP(otpCode: String, callback: @escaping (Error?) -> Void) {
        guard let verificationID = UserDefaults.standard.string(forKey: AuthService.authVerificationIDKey) else {
            callback(SCError(localizedDescription: "Please Resend OTP"))
            return
        }
        
        let creds = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: otpCode)
        Auth.auth().signIn(with: creds){ _, error in
            callback(error)
        }
    }
    
    func getVendor() -> SCVendor! {
        guard let vendorDict = UserDefaults.standard.dictionary(forKey: AuthService.venderKey) else {
            return nil
        }
        
        let vendor = try! SCVendor(fromDictionary: vendorDict)
        return vendor
    }
    
    func isVenderLoaded() -> Bool {
        guard let vendorDict = UserDefaults.standard.dictionary(forKey: AuthService.venderKey) else {
            return false
        }
        
        return true
    }
    
    func saveVendor(callBack: @escaping (Bool) -> Void) {
        if let phoneNumber = phoneNumber {
            SCNetwork.shared.requestData(.getVenderDetails(request: .init(phoneNumber: phoneNumber)), callback:{( vendor: SCVendor?, error: Error?) in
                if let error {
                    callBack(false)
                    return
                }
                
                if let vendor {
                    let dict = try? vendor.toDictionary()
                    UserDefaults.standard.set(dict, forKey: AuthService.venderKey)
                    callBack(true)
                }
            })
        }
//        let dict = try? vendor.toDictionary()
//        UserDefaults.standard.set(dict, forKey: AuthService.venderKey)
    }
}

struct SCError: Error {
    var localizedDescription: String
    
}
