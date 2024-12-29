//
//  AddProductsRepository.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 12/12/24.
//

//protocol AddProductsRepository {
//    func fetchVender(id: String) async throws -> SCProduct
//    func createVender(user: User) async throws
//    // Add other needed functions
//}
//
class AddProductsRepository {
    func getuploadURL(_ endpoint: SCServices, callback: @escaping (SettingsModels.UploadImage.Response?, Error?) -> Void)  {
        SCNetwork.shared.requestData(endpoint,callback: callback)
    }
    
    func addProduct(_ product: AddProductsModel.AddProduct.Request, callback: @escaping (SCProduct?, Error?) -> Void)  {
        SCNetwork.shared.requestData(.addProduct(request: product), callback: callback)
    }
}
