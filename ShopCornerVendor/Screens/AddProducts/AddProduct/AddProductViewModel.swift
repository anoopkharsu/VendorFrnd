//
//  AddProductViewModel.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 11/12/24.
//
import SwiftUI

class AddProductViewModel: ObservableObject {
    @Published var product: SCProduct
    
    init() {
        let vendorID = AuthService.shared.getVendor().id
        self.product = SCProduct(
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
    
    func saveProduct() -> Bool {
//        if product.productName.isEmpty || product.productDescription.isEmpty || unit.isEmpty || price.isEmpty {
////            return Alert.init(title: Text("Error"), message: Text("Please fill all fields"), dismissible: true)
//            return false
//        }
//        product.productPrices = price
        for i in 0..<self.product.variants.count {
            self.product.variants[i].setPrices()
        }
        self.product.variants[0].isBaseVariant = true
        return true
    }
}
