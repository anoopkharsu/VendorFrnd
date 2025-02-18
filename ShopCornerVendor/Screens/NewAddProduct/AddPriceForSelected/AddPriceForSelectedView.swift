//
//  AddPriceForSelectedView.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 10/02/25.
//

import SwiftUI

struct AddPriceForSelectedView: View {
    @StateObject var viewModel: AddPriceForSelectedViewModel
    let dismiss: () -> Void
    let back: () -> Void
    
    var body: some View {
        
        VStack {
            HStack {
                Button {
                    back()
                }label: {
                    Image(systemName: "chevron.backward")
                        .font(.title)
                        .frame(width: 30,height: 30)
                        .roundedButtonStyle(radius: 20)
                }
                Spacer()
            }
            .padding(.horizontal)
            if viewModel.products.isEmpty {
                // Fallback when there are no products.
                Text("No products available")
                    .foregroundColor(.gray)
                    .font(.headline)
            } else {
                // Display the current product
                let index = viewModel.currentIndex
                
                // Make sure we don’t go out of bounds
                if index < viewModel.products.count {
                    let product = viewModel.products[index]
                    ScrollView {
                        VStack(alignment: .leading) {
                            Image(product.name)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            Text(product.name)
                                .font(.title2)
                                .bold()
                            
                            ProductPriceView(isExpanded: true,title: "Product Price", variants: $viewModel.products[index].variants)
                        }
                        .padding()
                    }
                }
                
                Spacer()
                
                VStack {
                    Text("Item \(index + 1) of \(viewModel.products.count)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    HStack {
                        Button(action: {
                            if viewModel.currentIndex > 0 {
                                viewModel.currentIndex -= 1
                            }
                        }) {
                            Text("Previous")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.orange, lineWidth: 1))
                        .foregroundStyle(.orange)
                        .disabled(viewModel.currentIndex == 0)
                        
                        Button(action: {
                            if viewModel.currentIndex < viewModel.products.count - 1 {
                                viewModel.currentIndex += 1
                            }
                        }) {
                            Text("Next")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)

                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.orange, lineWidth: 1))
                        .foregroundStyle(.orange)
                        .disabled(viewModel.currentIndex == viewModel.products.count - 1)
                    }
                    Button(action: {
                        viewModel.saveProduct {
                            self.dismiss()
                        }
                    }) {
                        Text("SAVE")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(.orange))
                    .foregroundStyle(.white)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .background(.white)
        .loading(isLoading: viewModel.isLoading)
        .toast(isPresented: $viewModel.isError, message: viewModel.errorMessage)
    }
}


