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
    @Binding var variants: [SCProductVariant]
    
    init(isExpanded: Bool = false, title: String?, variants: Binding<[SCProductVariant]>) {
        self.isExpanded = isExpanded
        self.title = title
        self._variants = variants
    }
    
    var body: some View {
        VStack(alignment: .leading,spacing: 8) {
            DisclosureGroup(isExpanded: $isExpanded) {
                ForEach(variants.indices, id: \.self) { index in
                    VStack {
                        if index > 0 {
                            HStack {
                                Spacer()
                                Button {
                                    self.variants.remove(at: index)
                                } label: {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundStyle(.red)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        VStack {
                            HStack(alignment: .bottom) {
                                CutstomTextField(title: "Product Unit", placeholder: "kg, Full, Half, box", text: $variants[index].priceUnit)
                                CutstomTextField(title: "Quantity", text: $variants[index].priceQuantityString)
                            }
                            CutstomTextField(title: "Price", text: $variants[index].priceValueString)
                        }
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.gray.opacity(0.05)))
                    }
                }
                HStack {
                    Spacer()
                    Button(action: {
                        variants.append(.init(id: variants.endIndex, variantLabel: "", priceUnit: "", priceValue: 0, priceQuantity: 0))
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
