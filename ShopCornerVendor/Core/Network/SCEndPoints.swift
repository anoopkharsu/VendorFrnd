//
//  SCEndPoints.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 11/12/24.
//

import Foundation

enum SCServices {
    case getVenderDetails(request: SettingsModels.GetVendor.Request)
    case uploadImage(request: SettingsModels.UploadImage.Request)
    case updateVenderDetails(request: SCVendor)
    case addProduct(request: AddProductsModel.AddProduct.Request)
    case getProducts(request: ProductsModel.Products.Request)
    case updateProduct(request: SCProduct)
    case updateVenderLocation(request: SCVendorLocation)
}
    
    

    
extension SCServices {
    
    var path: String {
        let host = "http://localhost:3000"
        switch self {
        case .getVenderDetails:
            return host+SCPaths.vendorDetails.rawValue
        case .uploadImage:
            return host+SCPaths.uploadUrl.rawValue
        case .updateVenderDetails:
            return host+SCPaths.updateVendorDetails.rawValue
        case .addProduct:
            return host + SCPaths.addProduct.rawValue
        case .getProducts(request: let request):
            return host + String(format: SCPaths.getProducts.rawValue, request.vendorId)
        case .updateProduct:
            return host + SCPaths.updateProduct.rawValue
        case .updateVenderLocation:
            return host + SCPaths.updateVendorLocation.rawValue
        }
    }
}


extension SCServices {
    func makeRequest() -> URLRequest {
        var req = URLRequest.init(url: URL(string: path)!)
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        switch self {
        case .getVenderDetails(let request):
            req.httpMethod = "POST"
            req.httpBody = try? JSONEncoder().encode(request) // Encode the request data into JSON
        case .uploadImage(let request):
            req.httpMethod = "POST"
            req.httpBody = try? JSONEncoder().encode(request)
        case .updateVenderDetails(let data):
            req.httpMethod = "PUT"
            req.httpBody = try? JSONEncoder().encode(data)

        case .addProduct(let data):
            req.httpMethod = "POST"
            req.httpBody = try? JSONEncoder().encode(data)
        case .updateProduct(let data):
            req.httpMethod = "POST"
            req.httpBody = try? JSONEncoder().encode(data)
        case .updateVenderLocation(let data):
            req.httpMethod = "POST"
            req.httpBody = try? JSONEncoder().encode(data)
        default:
            req.httpMethod = "GET"
        }
        return req
    }
}
