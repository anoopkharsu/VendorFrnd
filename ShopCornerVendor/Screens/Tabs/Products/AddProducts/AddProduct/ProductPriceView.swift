//
//  ProductPriceView.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 11/12/24.
//
import SwiftUI

struct ProductPriceView: View {
    @State var isExpanded = false
    
    let title: String?
    @Binding var prices: [SCProductPrice]
    
    var body: some View {
        VStack(alignment: .leading,spacing: 8) {
            DisclosureGroup(isExpanded: $isExpanded) {
                ForEach(prices.indices, id: \.self) { index in
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                self.prices.remove(at: index)
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundStyle(.red)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        VStack {
                            HStack(alignment: .bottom) {
                                CutstomTextField(title: "Product Unit", placeholder: "kg, Full, Half, box", text: $prices[index].unit)
                                CutstomTextField(title: "Quantity", text: $prices[index].quantity)
                            }
                            CutstomTextField(title: "Price", text:  $prices[index].price)
                        }
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.gray.opacity(0.1)))
                    }
                }
                HStack {
                    Spacer()
                    Button(action: {
                        prices.append(.init(unit: "", price: "", quantity: ""))
                    }) {
                        Text("Add Price")
                            .font(.footnote)
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            } label: {
                Text("Price Details")
                    .padding(.leading,8)
            }
            
        }
        .listRowSeparator(.hidden)
        .listRowInsets(.init(top: 12, leading: 12, bottom: 8, trailing: 12))
    }
}
