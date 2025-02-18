//
//  EditProductViewModel.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 21/12/24.
//
import SwiftUI

class EditProductViewModel: ObservableObject {
    @Published var product: EditProductModel
    @Published var isLoading: Bool = false
    @Published var error: SCToastMessage?
    @Published var showError = false
    @Published var newImage: UIImage?
    
    let repository = EditProductRepository()
    
    init(product: EditProductModel) {
        self.product = product
        self.product.updateVariantsStringData()
    }
    
    func update(success:@escaping () -> Void) {
        self.isLoading = true
        var updatedProduct = product.product
        updatedProduct.updateVariantsIntegerData()
        if let newImage {
            uploadImage(newImage) {[weak self] downloadURL, error in
                self?.isLoading = false
                if let error {
                    self?.error = SCToastMessage(message: error.localizedDescription, type: .error)
                    self?.showError = true
                }
                if let downloadURL {
                    self?.isLoading = true
                    updatedProduct.imageURL = downloadURL
                    self?.uploadProduct(updatedProduct) { error in
                        self?.isLoading = false
                        if let error {
                            self?.showError = true
                            self?.error = SCToastMessage(message: error.localizedDescription, type: .error)
                        } else {
                            success()
                        }
                    }
                    
                }
            }
        } else {
            self.uploadProduct(updatedProduct) {[weak self] error in
                self?.isLoading = false
                if let error {
                    self?.showError = true
                    self?.error = SCToastMessage(message: error.localizedDescription, type: .error)
                } else {
                    success()
                }
            }
        }
    }
    
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
    func uploadProduct(_ product: SCProduct, completion: @escaping (Error?) -> Void) {
        repository.updateProduct(product) { _, error in
            completion(error)
        }
    }
}
