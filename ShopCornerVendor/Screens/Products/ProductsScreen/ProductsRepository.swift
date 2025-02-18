//
//  ProductsRepository.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 20/12/24.
//


class ProductsRepository {
    func fetchProducts(vendorId: Int, callback: @escaping([SCProduct]? , Error?) -> Void) {
        SCNetwork.shared.requestData(.getProducts(request: .init(vendorId: vendorId)), callback: callback)
    }
}
