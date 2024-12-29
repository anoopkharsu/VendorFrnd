//
//  AddProductsModel.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 10/12/24.
//

import Foundation
import UIKit

struct AddProductsModel {

    var parentCategory1: String = ""
    var parentCategory2: String = ""
    var category: String = ""
    
    var products: [ProductData] = []
    
    mutating func addProduct(product: ProductData) {
        var product = product
        product.categoryName = category
        products.append(product)
    }
    
    
    
    struct ProductData: Identifiable {
        var id = UUID()
        
        var productName: String = ""
        var productDescription: String = ""
        var productPrices: [SCProductPrice] = []//unit -> price
        var categoryName: String = ""
        var productImage: UIImage?
        var LocalKeywordsTags = ""
            
        func getRequest( url: String, venderID: Int) -> AddProduct.Request {
            .init(
                name: self.productName,
                description: self.productDescription,
                category: self.categoryName,
                price: self.productPrices,
                stockQuantity: 0,
                imageUrl: url,
                vendorID: venderID,
                outOfStock: false
            )
        }
        
    }
    
    enum AddProduct {
        struct Request: Codable {
            var name: String
            var description: String
            var category: String
            var price: [SCProductPrice]
            var stockQuantity: Int
            var imageUrl: String
            var vendorID: Int
            var outOfStock: Bool
            
            enum CodingKeys: String, CodingKey {
                case name
                case description
                case category
                case price
                case stockQuantity = "stock_quantity"
                case imageUrl = "image_url"
                case vendorID = "vendor_id"
                case outOfStock = "out_of_stock"
            }
        }
    }
}
