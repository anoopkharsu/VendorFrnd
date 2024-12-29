//
//  ProductsViewModel.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 20/12/24.
//
import SwiftUI

class ProductsViewModel: ObservableObject {
    @Published var model = ProductsModel()
    let repository: ProductsRepository = ProductsRepository()
    
    
    func fetchProducts() {
//        if model.products.isEmpty {
            let id = AuthService.shared.getVendor().id
            repository.fetchProducts(vendorId: id) {[weak self] products, error in
                if let products {
                    self?.model.products = products
                }
            }
//        }
    }
}
