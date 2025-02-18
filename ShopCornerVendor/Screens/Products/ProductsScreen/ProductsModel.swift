//
//  ProductsModel.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 20/12/24.
//

struct ProductsModel {
    var products: [SCProduct] = []
    
    enum Products {
        struct Request: Codable {
            var vendorId: Int
            
            enum CodingKeys: String, CodingKey {
                case vendorId = "vendor_id"
            }
        }
    }
}
