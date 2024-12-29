//
//  SCPaths.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 14/12/24.
//

enum SCPaths: String {
    case vendorDetails = "/vendor/get-or-create"
    case uploadUrl = "/vendor/upload-url" //getImageUploadURL
    case updateVendorDetails = "/vendor/update"
    case addProduct = "/product/add"
    case updateProduct = "/product/update"
    case getProducts = "/vendor/%d/products"
    case updateVendorLocation = "/vendor/location"
}
