//
//  SCEndPoints.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 11/12/24.
//

import Foundation

enum SCServices {
    case getOTP(phoneNumber: String)
    case verfiyOTP(phoneNumber: String, otp: String)
    case getVenderDetails(request: SettingsModels.GetVendor.Request)
    case uploadImage(request: SettingsModels.UploadImage.Request)
    case updateVenderDetails(request: SCVendor)
    case addProduct(request: SCProduct)
    case getProducts(request: ProductsModel.Products.Request)
    case updateProduct(request: SCProduct)
    case updateVenderLocation(request: SCVendorLocation)
    case getVendorPendingOrders(vendor_id: Int )
    case updateOrderStatustoProcessing(orderId: Int)
    case getVendorProcessingOrders(vendor_id: Int )
    case getVendorOtherOrders(vendor_id: Int )
    case updateOrderStatustoShipped(orderId: Int)
    case updateOrderStatustoDelivered(orderId: Int, otp: String)
    case addFCMToken(vendor_id: Int, fcm_token: String )
}
    
    

    
extension SCServices {
    
    var path: String {
        let host = "https://shope-corner-backend.onrender.com"
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
        case .getVendorPendingOrders:
            return host + SCPaths.getVodorPendingOrders.rawValue
        case .updateOrderStatustoProcessing:
            return host + SCPaths.updateOrderStatusToProcessing.rawValue
        case .getVendorProcessingOrders:
            return host + SCPaths.getVodorProcessingOrders.rawValue
        case .getVendorOtherOrders:
            return host + SCPaths.getVodorOtherOrders.rawValue
        case .updateOrderStatustoShipped:
            return host + SCPaths.updateOrderStatusToShipped.rawValue
        case .updateOrderStatustoDelivered:
            return host + SCPaths.updateOrderStatusToDelivered.rawValue
        case .getOTP:
            return host + SCPaths.getOTP.rawValue
        case .verfiyOTP:
            return host + SCPaths.verfiyOTP.rawValue
        case .addFCMToken:
            return host + SCPaths.addFCMToken.rawValue
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
        case .getVendorPendingOrders(let vendor_id):
            req = getPostRequest(body: ["vendor_id": vendor_id])!
        case .updateOrderStatustoProcessing(let order_id):
            req = getPostRequest(body: ["order_id": order_id])!
        case .getVendorProcessingOrders(let vendor_id):
            req = getPostRequest(body: ["vendor_id": vendor_id])!
        case .getVendorOtherOrders(let vendor_id):
            req = getPostRequest(body: ["vendor_id": vendor_id])!
        case .updateOrderStatustoShipped(let orderId):
            req = getPostRequest(body: ["order_id": orderId])!
        case .updateOrderStatustoDelivered(let orderId, let otp):
            req = getPostRequest(body: ["order_id": orderId, "otp": otp])!
        case .getOTP(let phoneNumber):
            req = getPostRequest(body: ["phone_number": phoneNumber])!
        case .verfiyOTP(let phoneNumber, let otp):
            req = getPostRequest(body: ["phone_number": phoneNumber, "otp": otp])!
        case .addFCMToken(let vendor_id,let fcm_token):
            req = getPostRequest(body: ["vendor_id": vendor_id,"fcm_token": fcm_token])!
        default:
            req.httpMethod = "GET"
        }
        return req
    }
    
    
    
    func getPostRequest(body: [String: Any]) -> URLRequest? {
        // Ensure the URL is valid
        guard let url = URL(string: path) else {
            return nil
        }

        // Create the URLRequest
        var req = URLRequest(url: url)
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpMethod = "POST"

        // Convert the dictionary to JSON data
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            req.httpBody = jsonData
        } catch {
            print("Error encoding JSON: \(error)")
            return nil
        }

        return req
    }
}
