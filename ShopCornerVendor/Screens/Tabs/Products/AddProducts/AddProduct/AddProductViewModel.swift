//
//  AddProductViewModel.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 11/12/24.
//
import SwiftUI

class AddProductViewModel: ObservableObject {
    @Published var product = AddProductsModel.ProductData()
    @Published var unit = ""
    @Published var price = [SCProductPrice]()
    
    
    func saveProduct() -> Bool {
        if product.productName.isEmpty || product.productDescription.isEmpty || unit.isEmpty || price.isEmpty {
//            return Alert.init(title: Text("Error"), message: Text("Please fill all fields"), dismissible: true)
            return false
        }
        product.productPrices = price
        return true
    }
}
