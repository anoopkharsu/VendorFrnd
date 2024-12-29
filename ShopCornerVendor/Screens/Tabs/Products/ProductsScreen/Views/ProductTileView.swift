//
//  ProductTileView.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 20/12/24.
//
import SwiftUI


struct ProductTileView: View {
    let product: SCProduct
    let maxWidth: CGFloat
    
    var body: some View {
        ZStack {
            VStack {
                CachedImageView(url: product.imageURL, placeholder: .init("image_product"))
                    .frame(height: maxWidth*0.7)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                VStack(alignment: .leading) {
                    
                    Text(product.name)
                        .font(.headline)
                        .lineLimit(2)
                    Text("\(product.price[0].quantity)\(product.price[0].unit)")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    VStack {
                        HStack {
                            Spacer()
                            Text("₹\(product.price[0].price)")
                                .font(.headline)
                            
                        }
                    }
                }
            }
        }
    }
}

