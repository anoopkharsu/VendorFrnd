//
//  SCPaths.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 14/12/24.
//

enum SCPaths: String {
    case vendorDetails = "/vendor"
    case uploadUrl = "/media/image/upload-url" //getImageUploadURL
    case updateVendorDetails = "/vendor/update"
    case addProduct = "/product/add"
    case updateProduct = "/product/update"
    case getProducts = "/vendor/%d/products"
    case updateVendorLocation = "/vendor/location"
    case getVodorPendingOrders = "/order/get/vendor/pending_orders"
    case getVodorProcessingOrders = "/order/get/vendor/processing_orders"
    case getVodorOtherOrders = "/order/get/vendor/other_orders"
    case updateOrderStatusToProcessing = "/order/update/vendor/status/processing"
    case updateOrderStatusToShipped = "/order/update/vendor/status/shipped"
    case updateOrderStatusToDelivered = "/order/update/vendor/status/delivered"
    case getOTP = "/vendor/send-otp"
    case verfiyOTP = "/vendor/verify-otp"
    case addFCMToken = "/vendor/add-fcm-token"
}
