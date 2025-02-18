//
//  SelectCategoryView.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 11/01/25.
//

import SwiftUI

struct SelectCategoryView: View {
    @StateObject var categoryVM = SelectCategoryViewModel()
    
    @State var heightGridView: CGFloat = 0
    let dismiss: () -> Void
    let selectOther: () -> Void
    

    var body: some View {
        if categoryVM.showSelectedItems {
            AddPriceForSelectedView(viewModel: .init(selectedItems: categoryVM.selectedItems)) {
                dismiss()
            } back: {
                withAnimation {
                    categoryVM.showSelectedItems.toggle()
                }
            }
            .transition(.move(edge: .bottom))
        } else {
            GeometryReader { geometry in
                VStack {
                    ZStack {
                        Color.black.opacity(0.08)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        dismiss()
                    }
                    let width = (geometry.size.width-24)/2
                    VStack(spacing:0) {
                        ScrollView {
                            // Wrap your grid in a ZStack to allow transitions when the state changes
                            ZStack {
                                if let last = categoryVM.items.last {
                                    LazyVGrid(columns: [GridItem(.fixed(width)), GridItem(.fixed(width))]) {
                                        ForEach(last) { item in
                                            SelectCategoryViewCell(text: item.name, category: item.type, isSelected: categoryVM.isItemSelected(item))
                                                .onTapGesture {
                                                    if !item.products.isEmpty {
                                                        // Animate the push action
                                                        withAnimation {
                                                            categoryVM.isPushed = true
                                                            categoryVM.items.append(item.products)
                                                        }
                                                    } else if item.type == "product" {
                                                        if item.name == "other" {
                                                            selectOther()
                                                        } else {
                                                            categoryVM.selectItem(item)
                                                        }
                                                    }
                                                }.transition(.identity)
                                        }
                                    }
                                }
                            }
                            .padding(12)
                            
                        }
                        .background(Color.white)
                        .frame(maxHeight: 500)
                        .fixedSize(horizontal: false, vertical: true)
                        HStack {
                            if categoryVM.items.count > 1 {
                                Button {
                                    // Animate the pop action
                                    withAnimation {
                                        categoryVM.isPushed = false
                                        let _ = categoryVM.items.popLast()
                                    }
                                } label: {
                                    HStack {
                                        Image(systemName: "chevron.left")
                                        Text("Back")
                                    }
                                }
                            }
                            Spacer()
                            Button {
                                withAnimation {
                                    categoryVM.showSelectedItems.toggle()
                                }
                            } label: {
                                HStack {
                                    Text("(\(categoryVM.selectedItems.count)) Next")
                                }
                            }
                        }
                        .padding()
                        
                    }
                    .background(Color.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -20)
                }
            }
        }
    }
    
    /// Returns an asymmetric transition based on whether we are pushing or popping.
    private func navigationTransition() -> AnyTransition {
        return .slide
    }
    
    private func navigationTransitionNext() -> AnyTransition {
       
            // When pushing, new content slides in from the right and the old content slides out to the left.
        return .identity
        
    }
}


struct SelectCategoryViewCell: View {
    let text: String
    let category: String
    let isSelected: Bool
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 0) {
                Spacer(minLength: 0)
                Image(text)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 130)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                Spacer(minLength: 0)
            }
            .overlay {
                VStack {
                    Spacer()
                    HStack {
                        Text(text)
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .padding(8)
                            .foregroundStyle(Color.white)
                        Spacer()
                    }
                    .padding(.top,6)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: isSelected ? [Color.orange, Color.clear] : [ Color.gray, Color.clear]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                }
            }
        }
        .padding(1)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 1)
                .foregroundStyle(isSelected ? .orange : .gray)
        )
    }
}
