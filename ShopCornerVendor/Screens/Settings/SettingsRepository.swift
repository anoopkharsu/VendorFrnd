//
//  SettingsRepository.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 14/12/24.
//


class SettingsRepository: SettingsRepositoryProtocol {
    func getVendorDetails(_ phoneNumber: String, callback: @escaping (SCVendor?, Error?) -> Void)  {
        SCNetwork.shared.requestData(.getVenderDetails(request: .init(phoneNumber: phoneNumber)), callback: callback)
    }
    
    func getuploadURL(_ endpoint: SCServices, callback: @escaping (SettingsModels.UploadImage.Response?, Error?) -> Void)  {
        SCNetwork.shared.requestData(endpoint,callback: callback)
    }
    
    func updateVendor(_ endpoint: SCServices, callback: @escaping (SCVendor?, Error?) -> Void)  {
        SCNetwork.shared.requestData(endpoint,callback: callback)
    }
    
    func updateVendorLocation(_ data: SCVendorLocation, callback: @escaping (SCVendor?, Error?) -> Void)  {
        SCNetwork.shared.requestData(.updateVenderLocation(request: data),callback: callback)
    }
}

protocol SettingsRepositoryProtocol {
    func getVendorDetails(_ phoneNumber: String, callback: @escaping (SCVendor?, Error?) -> Void)
}
