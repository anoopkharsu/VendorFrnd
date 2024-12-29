//
//  EditProductRepository.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 21/12/24.
//

class EditProductRepository {
    func getuploadURL(_ endpoint: SCServices, callback: @escaping (SettingsModels.UploadImage.Response?, Error?) -> Void)  {
        SCNetwork.shared.requestData(endpoint,callback: callback)
    }
    
    func updateProduct(_ product: SCProduct, callback: @escaping (SCProduct?, Error?) -> Void)  {
        SCNetwork.shared.requestData(.updateProduct(request: product),callback: callback)
    }
}
