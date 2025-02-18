//
//  AddPriceForSelectedViewModel.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 11/02/25.
//

import SwiftUI

class AddPriceForSelectedViewModel: ObservableObject {
    @Published var products = [SCProduct]()
    @Published var currentIndex: Int = 0
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: SCToastMessage?
    let repository = AddProductsRepository()
    
    init(selectedItems: [SelectCategoryModel.Item]) {
        for selectedItem in selectedItems {
            var product = SCProduct.getNewProduct()
            product.name = selectedItem.name
            product.category = selectedItem.category
            product.description = selectedItem.name
            product.productImage = .init(named: selectedItem.name)
            products.append(product)
        }
    }
    
    
    func saveProduct(dismiss: @escaping () -> Void) {

        for i in 0..<self.products.count {
            for j in 0..<self.products[i].variants.count {
                self.products[i].variants[j].setPrices()
                if self.products[i].variants[j].priceValue == 0 || self.products[i].variants[j].priceUnit.isEmpty || self.products[i].variants[j].priceQuantity == 0 {
                    self.currentIndex = i
                    self.isError = true
                    self.errorMessage = .init(message: "Please add price", type: .error)
                    return
                }
            }
            self.products[i].variants[0].isBaseVariant = true
        }
        validateAndSaveProducts(dismiss: dismiss)
    }
    
    func validateAndSaveProducts(dismiss: @escaping () -> Void) {
        self.isLoading = true
        uploadNextProduct(at: 0, completion: {[weak self] error in
            self?.isLoading = false
            if let error {
                self?.isError = true
                self?.errorMessage = .init(message: error.localizedDescription, type: .error)
                print("Error uploading products: \(error)")
            } else {
                dismiss()
            }
            
        })
        
    }
    
  
    
    private func uploadNextProduct(at index: Int, completion: @escaping (Error?) -> Void) {
        if index >= self.products.count {
            completion(nil)
            return
        }
        let product = products[index]
        
        guard let image = product.productImage else {
            print("Product \(product.name) has no image. Skipping.")
            uploadNextProduct(at: index + 1, completion: completion)
            return
        }
        
        uploadImage(image) {[weak self] url, error in
            if let error {
                completion(error)
                return
            }
            if let url {
                self?.uploadProduct(product, url: url) { error in
                    if let error {
                        completion(error)
                        return
                    }
                    self?.uploadNextProduct(at: index + 1, completion: completion)
                }
            } else {
                completion(SCError(localizedDescription: "Upload failed"))
            }

        }
    }
    
    // Modify uploadImage and uploadProduct to use completion handlers
    func uploadImage(_ image: UIImage, completion: @escaping (String?, Error?) -> Void) {
        guard let imageData = image.resized() else {
            completion(nil,SCError(localizedDescription: "Invaild image"))
            return
        }
        let uploadRequest = SettingsModels.UploadImage.Request(fileName: "product.jpg", fileType: "image/jpeg")
        
        repository.getuploadURL(.uploadImage(request: uploadRequest)) { uploadData, error in
           
            
            if let error = error {
                completion(nil,error)
                return
            }
            
            guard let uploadData = uploadData,
                  let uploadURL = URL(string: uploadData.uploadUrl) else {
                completion(nil,SCError(localizedDescription: "Invaild upload URL"))
                return
            }
            
            SCNetwork.shared.uploadImage(to: uploadURL, imageData: imageData) { uploadError in
                if let uploadError {
                    completion(nil,uploadError)
                } else {
                    completion(uploadData.fileKey,nil)
                }
            }
        }
    }
//
    func uploadProduct(_ product: SCProduct, url: String, completion: @escaping (Error?) -> Void) {
        let vendId = AuthService.shared.getVendor().id
        var product = product
        product.imageURL = url
        repository.addProduct(product) { _, error in
            completion(error)
        }
        // Implement similar to the async version but use completion handlers
    }
}
