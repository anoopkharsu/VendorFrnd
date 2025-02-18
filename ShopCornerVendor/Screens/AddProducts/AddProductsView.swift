//
//  AddProductsView.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 08/12/24.
//


import SwiftUI

struct AddProductsView: View {
    @StateObject private var viewModel = AddProductsViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Category")) {
                    Picker("Parent Category 1", selection: $viewModel.product.parentCategory1) {
                        Text("Select Category").tag("")
                        ForEach(viewModel.categories) { category in
                            Text(category.name).tag(category.name)
                        }
                    }
                    
                    Picker("Parent Category 2", selection: $viewModel.product.parentCategory2) {
                        Text("Select Category").tag("")
                        if let category = viewModel.getSelectedCategory() {
                            ForEach(category.subcategories) { subCategory in
                                Text(subCategory.name).tag(subCategory.name)
                            }
                        }
                    }
                    
                    Picker("Category", selection: $viewModel.product.category) {
                        Text("Select Category").tag("")
                        if let category = viewModel.getSelectedTypes() {
                            ForEach(category, id: \.self) { subCategory in
                                Text(subCategory).tag(subCategory)
                            }
                        }
                    }
                    
                    HStack {
                        Spacer()
                        Text("Add Category")
                            .foregroundStyle(.blue)
                            .onTapGesture {
                                print("ZDsdf")
                            }
                            
                    }
                }

                Section(header: Text("Add Products")) {
                    ForEach(viewModel.product.products) { product in
                        HStack {
                            Text(product.name)
                            Spacer()
//                            Text(product.productPrices.values.first! + "/" + product.productPrices.keys.first! )
                        }
                    }
                    HStack {
                        Spacer()
                        NavigationLink {
                            AddProductView( saveProduct: { product in
                                self.viewModel.addProduct(product: product)
                            })
                        } label: {
                            Text("Add Product")
                                .foregroundStyle(.blue)
                        }
                    }
                }
                
                Section {
                    
                        Button(action: {
                            viewModel.validateAndSaveProducts {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            Text("Save Products")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    
                }
            }
            .navigationTitle("Add Products")
            

        }
        .toast(isPresented: self.$viewModel.showError, message: self.viewModel.errorMessage)
        .loading(isLoading: self.viewModel.isLoading)
 
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductsView()
    }
}
