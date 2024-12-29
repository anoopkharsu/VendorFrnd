//
//  SCProduct.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 18/12/24.
//

import Foundation


struct SCProduct: Codable, Identifiable, Hashable {
    /// Unique identifier for the product (Primary Key)
    var id: Int
    /// Auto-generated UUID for the product
    var productID: UUID
    /// Name of the product
    var name: String
    /// Detailed description of the product
    var description: String
    /// Category or subcategory of the product
    var category: String
    /// Price of the product as a dictionary (e.g., size: price or currency: price)
    var price: [SCProductPrice]
    /// Current stock quantity
    var stockQuantity: Int
    /// URL to the product's image
    var imageURL: String
    /// Identifier for the vendor offering the product
    var vendorID: Int
    /// Timestamp when the product was added
    var dateAdded: String

    var outOfStock: Bool  = false
    /// Maps Swift property names to JSON keys
    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case name
        case description
        case category
        case price
        case stockQuantity = "stock_quantity"
        case imageURL = "image_url"
        case vendorID = "vendor_id"
        case dateAdded = "date_added"
        case outOfStock = "out_of_stock"
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
