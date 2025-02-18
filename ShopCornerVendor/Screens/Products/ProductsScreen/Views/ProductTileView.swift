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
                AsyncImage(url: URL(string: product.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    // Placeholder while loading the image
                    Color.gray
                }
                .frame(height: maxWidth*0.7)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                VStack(alignment: .leading) {
                    
                    Text(product.name)
                        .font(.headline)
                        .lineLimit(2)
                    Text("\(product.variants[0].getQuantityString())")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    VStack {
                        HStack {
                            Spacer()
                            Text("\(product.variants[0].getCostPriceString())")
                                .font(.headline)
                            
                        }
                    }
                }
                .padding(8)
            }
            
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle(lineWidth: 2))
                    .foregroundStyle(.gray.opacity(0.2))
            )
            .padding(.bottom,8)
            
        }
    }
}

