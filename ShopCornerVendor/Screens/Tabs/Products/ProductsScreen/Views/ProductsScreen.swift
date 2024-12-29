//
//  ProductsScreen.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 08/12/24.
//

import SwiftUI

struct ProductsScreen: View {
    @State var isEditing: Bool = false
    @StateObject var productsViewModel: ProductsViewModel = ProductsViewModel()
    @State var heightGridView: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CustomTopBar(
                    trailingText: "Add",
                    trailingAction: {
                        isEditing.toggle()
                    }
                )
                ScrollView {
                    VStack {
                        DynamicWidthGrid(height: $heightGridView, items: productsViewModel.model.products) {  product in
                            
                            NavigationLink {
                                EditProductView(product: .init(product: product))
                            } label: {
                                ProductTileView(product: product, maxWidth: (geometry.size.width/3)-10.6)
                                    .frame(width: (geometry.size.width/3)-10.6)
                                    .fixedSize()
                            }
                            .padding(.leading,8)
                            .buttonStyle(.plain)
                        }
                        
                        
                    }
                }
            }
            
        }
        .navigationBarHidden(true)
        .onAppear {
            productsViewModel.fetchProducts()
        }
        .sheet(isPresented: $isEditing) {
            AddProductsView()
        }
    }
}







struct CustomTopBar: View {
    /// Title text displayed in the center
    let title: String? = nil
    
    /// Optional image name or SF Symbol for the leading button
    let leadingIcon: String? = nil
    
    /// Action performed when leading button is tapped
    var leadingAction: (() -> Void)? = nil
    
    /// Optional image name or SF Symbol for the trailing button
    let trailingText: String?
    
    /// Action performed when trailing button is tapped
    var trailingAction: (() -> Void)?
    
    var body: some View {
        HStack {
            // Leading button (if provided)
            if let leadingIcon = leadingIcon, let leadingAction = leadingAction {
                Button(action: leadingAction) {
                    Image(systemName: leadingIcon)
                }
                .padding(.leading, 16)
            } else {
                // If no leading icon, just an empty space so Title can be centered
                Spacer().frame(width: 40)
            }
            
            Spacer()
            
            // Title in the middle
            if let title {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            Spacer()
            
            // Trailing button (if provided)
            if let trailingText, let trailingAction {
                Button(action: trailingAction) {
                    Text(trailingText)
                }
                .padding(.trailing, 16)
            } else {
                // If no trailing icon, just an empty space so Title can be centered
                Spacer().frame(width: 40)
            }
        }
        .frame(height: 44)
        .overlay(
            Divider()
            , alignment: .bottom
        )
    }
}
