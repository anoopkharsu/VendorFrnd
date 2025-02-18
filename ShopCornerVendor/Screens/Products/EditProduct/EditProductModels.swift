//
//  EditProductModels.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 21/12/24.
//

struct EditProductModel {
    var hasChanges: Bool = false
    var product: SCProduct {
        didSet {
            hasChanges = true
        }
    }
    
    init(product: SCProduct) {
        self.product = product
    }
    
    mutating func updateVariantsStringData() {
        product.updateVariantsStringData()
    }
    
    mutating func updateVariantsIntegerData() {
        product.updateVariantsIntegerData()
    }
    
}
