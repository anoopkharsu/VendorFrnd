//
//  SettingsModels.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 07/12/24.
//

import SwiftUI

enum SettingsModels {
    enum GetVendor {
        struct Request: Codable {
            var phoneNumber: String
        }
        
        struct Response: Codable {
            var vendor: SCVendor?
        }
    }
    
    enum UploadImage {
        struct Request: Codable {
            var fileName: String
            var fileType: String
        }
        
        struct Response: Codable {
            var uploadUrl: String
            var fileKey: String
        }
    }
}


struct SCVendor: Codable {
    var id: Int
    var photo: String?
    var email: String?
    var phone_number: String
    var shop_name: String?
    var address: String?
    var owner_name: String?
    var longitude: Double?
    var latitude: Double?
}
