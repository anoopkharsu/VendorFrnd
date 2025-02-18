//
//  AuthService.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 02/12/24.
//

import Foundation
import Combine

class AuthService: ObservableObject {
    @Published var vendor: SCVendor?
    @Published var authToken: String?
    
    static let venderKey = "vendor"
    static let authToken = "authToken"
    static let shared = AuthService()
    
    
    init() {
        authToken = UserDefaults.standard.string(forKey: AuthService.authToken)
        vendor = getVendor()
    }
    
   
    var phoneNumber: String? {
        if getVendor() == nil {
            return nil
        }
        return getVendor().phone_number
    }
    var isUserLoggedIn: Bool {
        return phoneNumber != nil
    }
    
    func getOTP(number: String, callback: @escaping (Error?) -> Void) {
        SCNetwork.shared.requestData(.getOTP(phoneNumber: number)) {(res: EmptyResponse?, error: Error?) in
            callback(error)
        }
    }
    
    func verifyOTP(number: String, otpCode: String, callback: @escaping (Error?) -> Void) {
        SCNetwork.shared.requestData(.verfiyOTP(phoneNumber: number, otp: otpCode)) {[weak self](res: OTPVerificationResponse?, error: Error?) in
            if let res {
                let vendor = res.vendor
                self?.authToken = res.token
                self?.vendor = vendor
                
                let dict = try? vendor.toDictionary()
                UserDefaults.standard.set(res.token, forKey: AuthService.authToken)
                UserDefaults.standard.set(dict, forKey: AuthService.venderKey)
                callback(nil)
            } else {
                if let error {
                    callback(error)
                } else {
                    callback(SCError(localizedDescription: "Something went wrong"))
                }
                
            }
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
    }
    struct OTPVerificationResponse: Codable {
        let token: String
        let vendor: SCVendor
    }
}


struct SCError: Error {
    var localizedDescription: String
    
}
