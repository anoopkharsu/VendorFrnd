//
//  SCVendorController.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 17/02/25.
//

import Foundation

class SCVendorController {
    var fcmToken: String? {return UserDefaults.standard.string(forKey: Keys.fcmToken)}
    static let shared = SCVendorController()
    
    
    
    
    
    
    func saveFCMToken(_ token: String) {
        if AuthService.shared.isUserLoggedIn {
            let id = AuthService.shared.getVendor().id
            SCNetwork.shared.requestData(.addFCMToken(vendor_id: id, fcm_token: token)) {(response: EmptyResponse?, error: Error?) in
                if let error {
                    print(error)
                } else {
                    UserDefaults.standard.set(token, forKey: Keys.fcmToken)
                }
            }
        }
    }
    
    
    
    private enum Keys {
        static let authToken = "authToken"
        static let phoneNumber = "phoneNumber"
        static let user = "user"
        static let activeCartId = "activeCartId"
        static let fcmToken = "fcmToken"
    }
}
