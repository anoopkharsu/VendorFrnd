//
//  SCProduct.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 18/12/24.
//

import Foundation
import SwiftUI


struct SCProduct: Codable, Identifiable, Hashable {
    
    var id: Int
    var name: String
    var description: String
    var category: String
    var variants: [SCProductVariant]
    var imageURL: String
    var vendorID: Int
    var createdAt: String
    var attributes: [String]?
    var outOfStock: Bool = false
    
    
    var productImage: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case category
        case variants
//        case stockQuantity = "stock_quantity"
        case imageURL = "image_url"
        case vendorID = "vendor_id"
        case createdAt = "created_at"
        case outOfStock = "out_of_stock"
        case attributes
    }
    
    static func == (lhs: SCProduct, rhs: SCProduct) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    mutating func updateVariantsStringData() {
        for i in variants.indices {
            variants[i].setPricesString()
        }
    }
    
    mutating func updateVariantsIntegerData() {
        for i in variants.indices {
            variants[i].setPrices()
        }
    }
    
    
    static func getNewProduct() -> SCProduct {
        let vendorID = AuthService.shared.getVendor().id
        return SCProduct(
            id: Int.random(in: 1...1000),
            name: "", description: "",
            category: "",
            variants: [
                SCProductVariant.init(
                    id: Int.random(in: 1...1000),
                    variantLabel: "",
                    priceUnit: "",
                    priceValue: 0,
                    priceQuantity: 0)
            ],
            imageURL: "",
            vendorID: vendorID,
            createdAt: ""
        )
    }
    
}


struct SCProductVariant: Codable, Identifiable, Hashable {
    var id: Int = UUID().hashValue
    var variantID: Int?
    var variantLabel: String
    var imageUrl: String?
    var isBaseVariant: Bool = false
   
    var priceUnit: String
    var priceValue: Double
    var priceQuantity: Double
    
    var priceValueString = ""
    var priceQuantityString = ""
    
//    var costPrice: SCProductPrice?
    var discount: Double?
    var additionalAttributes: [String]?
    
    
    func getPriceString() -> String {
        return "₹"+String(format: "%.0f", priceValue)
    }
    
    func getCostPriceString() -> String {
        return self.getPriceString()
    }
    
    func getQuantityString() -> String {
        return String(format: "%.0f", priceQuantity) + priceUnit
    }
    
    enum CodingKeys: String, CodingKey {
        case variantID = "variant_id"
        case variantLabel = "variant_label"
        case imageUrl = "image_url"
        case isBaseVariant = "is_base_variant"
        case priceUnit = "price_unit"
        case priceValue = "price_value"
        case priceQuantity = "price_quantity"
        case discount
        case additionalAttributes
    }
    
    mutating func setPrices()  {
        priceValue = Double(priceValueString) ?? 0
        priceQuantity = Double(priceQuantityString) ?? 0
    }
    
    mutating func setPricesString()  {
        priceValueString = "\(priceValue)"
        priceQuantityString = "\(priceQuantity)"
    }
}


struct SCProductPrice: Codable, Hashable, Identifiable  {
    let id = UUID().uuidString
    var unit: String
    var price: String
    var quantity: String
    
    
    enum CodingKeys: String, CodingKey {
        case unit
        case price
        case quantity
    }
}
