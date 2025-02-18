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
    
    var products: [SCProduct] = []
    
    mutating func addProduct(product: SCProduct) {
        var product = product
        product.category = category
        while products.contains(where: { $0.id == product.id }) {
            product.id = Int.random(in: 1...1000000)
        }
        products.append(product)
    }
    

}
