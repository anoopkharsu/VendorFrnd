//
//  OrderRepository.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 31/01/25.
//

class OrderRepository {
    
    func getVendorPendingOrders(vendorId: Int, callback: @escaping ([OrderModels.Order.Order]?,Error?) -> Void) {
        SCNetwork.shared.requestData(.getVendorPendingOrders(vendor_id: vendorId), callback: callback)
    }
    
    func markOrderToProcessing(orderId: Int, callback: @escaping (EmptyResponse?,Error?) -> Void) {
        SCNetwork.shared.requestData(.updateOrderStatustoProcessing(orderId: orderId), callback: callback)
    }
    
    func markOrderToShipped(orderId: Int, callback: @escaping (EmptyResponse?,Error?) -> Void) {
        SCNetwork.shared.requestData(.updateOrderStatustoShipped(orderId: orderId), callback: callback)
    }
    
    func getVendorProcessingOrders(vendorId: Int, callback: @escaping ([OrderModels.Order.Order]?,Error?) -> Void) {
        SCNetwork.shared.requestData(.getVendorProcessingOrders(vendor_id: vendorId), callback: callback)
    }
    
    func getVendorOtherOrders(vendorId: Int, callback: @escaping ([OrderModels.Order.Order]?,Error?) -> Void) {
        SCNetwork.shared.requestData(.getVendorOtherOrders(vendor_id: vendorId), callback: callback)
    }
    
    
}

struct EmptyResponse: Codable {
    
}
