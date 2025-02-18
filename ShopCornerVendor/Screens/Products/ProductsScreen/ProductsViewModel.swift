//
//  ProductsViewModel.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 20/12/24.
//
import SwiftUI

class ProductsViewModel: ObservableObject {
    @Published var model = ProductsModel()
    @Published var isLoading = false
    let repository: ProductsRepository = ProductsRepository()
    
    
    func fetchProducts() {
        isLoading = true
        self.model.products = []
        let id = AuthService.shared.getVendor().id
        repository.fetchProducts(vendorId: id) {[weak self] products, error in
            self?.isLoading = false
            if let products {
                self?.model.products = products
            }
        }
        //        }
    }
}
