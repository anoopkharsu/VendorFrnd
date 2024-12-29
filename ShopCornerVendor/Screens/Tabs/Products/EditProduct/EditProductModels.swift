//
//  EditProductModels.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 21/12/24.
//

struct EditProductModel {
    // Properties copied from SCProduct
    
    var name: String
    var price: [SCProductPrice]
    var description: String
    var category: String
    var stockQuantity: Int
    var imageURL: String
    var isOutOfStock: Bool
    let product: SCProduct
    
    init(product: SCProduct) {
        self.product = product
        
        self.name = product.name
        self.price = product.price
        self.description = product.description
        self.category = product.category
        self.stockQuantity = product.stockQuantity
        self.imageURL = product.imageURL
        self.isOutOfStock = product.outOfStock
        // Initialize any additional properties here
    }
    
    func hasChanges() -> Bool {
        return name != product.name
        || price != product.price
        || description != product.description
        || category != product.category
        || stockQuantity != product.stockQuantity
        || isOutOfStock != product.outOfStock
    }
    
    func updatedProduct() -> SCProduct {
        var newProduct = product
        newProduct.name = name
        newProduct.price = price
        newProduct.description = description
        newProduct.category = category
        newProduct.stockQuantity = stockQuantity
        newProduct.imageURL = imageURL
        newProduct.outOfStock = isOutOfStock
        return newProduct
    }
}
