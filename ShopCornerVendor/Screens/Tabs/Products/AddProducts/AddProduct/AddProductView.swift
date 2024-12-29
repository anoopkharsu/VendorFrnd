//
//  AddProductView.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 10/12/24.
//
import SwiftUI

struct AddProductView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = AddProductViewModel()
    let saveProduct: (AddProductsModel.ProductData) -> Void
    @State var image: UIImage?
    var body: some View {
        List {
            ImagePickerView() {
                if let selectedImage = image {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 10))
                        .frame(width: 130,height: 130)
                } else {
                    HStack {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 130,height: 130)
                        Text("Tap to add an image")
                    }
                    
                }
            } onImageSelected: { i in
                self.image = i
                viewModel.product.productImage = image
            }
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: 12, leading: 12, bottom: 8, trailing: 12))
            
            
            
            
            CutstomTextField(title: "Product Name", text: $viewModel.product.productName)
            CutstomTextField(title: "Local Keywords/Tags", text: $viewModel.product.LocalKeywordsTags)
            
            ProductPriceView(title: "Product Price", prices: $viewModel.price)

            CutstomTextEditor(title: "Product Description",text: $viewModel.product.productDescription)
                .frame(minHeight: 70) // Provide ample vertical space
            
        }
        .listStyle(.plain)
//        .navigationTitle("Add Product")
        .navigationBarItems(
            trailing: Button("Add") {
                
                if viewModel.saveProduct() {
                    saveProduct(viewModel.product)
                    dismiss()
                }
            }
        )
    }
}
