//
//  EditProductView.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 21/12/24.
//

import SwiftUI

struct EditProductView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: EditProductViewModel
    @State var textt = ""
    
    init(product: EditProductModel) {
        self._viewModel = StateObject(wrappedValue: EditProductViewModel(product: product))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 0) {
                    GeometryReader { size in
                        ImagePickerView() {
                            if let selectedImage =  self.viewModel.newImage {
                                AsyncImage(url: nil) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Image(uiImage: selectedImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                }
                                .frame(width: size.size.width, height: 330)
                                .clipped()
                            } else {
                                AsyncImage(url: URL(string: viewModel.product.product.imageURL)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: size.size.width, height: 330)
                                .clipped()
                            }
                        } onImageSelected: { image in
                            self.viewModel.newImage = image
                        }
                    }
                    .frame(height: 330)
                    .clipped()
                    .contentShape(Rectangle())
                    
                    VStack(spacing: 12) {
                        
                        CutstomTextField(title: "Product Name", text: $viewModel.product.product.name)
                        CutstomTextField(title: "Product Category", text: $viewModel.product.product.category)
                        Toggle(isOn: $viewModel.product.product.outOfStock, label: { Text("Out Of Stock") })
                            .listRowSeparator(.hidden)
                            .listRowInsets(.init(top: 12, leading: 12, bottom: 8, trailing: 12))
                            .padding(.leading,8)
                        ProductPriceView(title: "Product Price", variants: $viewModel.product.product.variants)
                        
                        CutstomTextEditor(title: "Product Description",text: $viewModel.product.product.description)
                            .frame(minHeight: 70) // Provide ample vertical space
                    }
                    .padding()
                }
                
                
            }
            
            if (viewModel.product.hasChanges || viewModel.newImage != nil) {
                Button {
                    viewModel.update {
                        dismiss()
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Save")
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding()
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding()
            }
        }
        .navigationBarHidden(false)
        .toast(isPresented: self.$viewModel.showError, message: self.viewModel.error)
        .loading(isLoading: self.viewModel.isLoading)
        //        .ignoresSafeArea(edges: .top)
        
    }
}





struct CustomBackButton: View {
    @Environment(\.dismiss) var dismiss  // For iOS 15+ (NavigationStack)
    
    @State private var savedStandardAppearance: UINavigationBarAppearance?
    @State private var savedScrollEdgeAppearance: UINavigationBarAppearance?
    @State private var savedTintColor: UIColor?
    
    // Create (but don’t apply) the transparent appearance
    private let transparentAppearance: UINavigationBarAppearance = {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.backgroundEffect = nil  // Removes any blur effect
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        return appearance
    }()
    
    var body: some View {
        Button(action: {
            // 3) Restore the old appearance so other screens aren’t affected
            if let oldStandard = self.savedStandardAppearance {
                UINavigationBar.appearance().standardAppearance = oldStandard
            }
            if let oldScrollEdge = self.savedScrollEdgeAppearance {
                UINavigationBar.appearance().scrollEdgeAppearance = oldScrollEdge
            }
            dismiss() // or presentationMode.wrappedValue.dismiss()
        }) {
            HStack(spacing: 4) {
                Image(systemName: "chevron.left")
                Text("Back")
            }
            .foregroundColor(.white)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color.blue.opacity(0.5))
            .cornerRadius(8)
        }
        .onAppear {
            // 1) Save the current appearance
            self.savedStandardAppearance = UINavigationBar.appearance().standardAppearance
            self.savedScrollEdgeAppearance = UINavigationBar.appearance().scrollEdgeAppearance
            self.savedTintColor = UINavigationBar.appearance().tintColor
            
            // 2) Apply your transparent appearance
            UINavigationBar.appearance().standardAppearance = transparentAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = transparentAppearance
            //            UINavigationBar.appearance().tintColor = .white
        }
        
        
    }
}

//
//
//
//
//struct CustomHeader: View {
//    let title: String
//
//    var body: some View {
//        ZStack(alignment: .leading) {
//            Color.blue
//            Text(title)
//                .font(.headline)
//                .foregroundColor(.white)
//                .padding()
//        }
//        .frame(height: 50)
//    }
//}
//
//struct ScrollViewWithPinnedHeaders: View {
//    var body: some View {
//        ScrollView {
//            LazyVStack(pinnedViews: [.sectionHeaders]) {
//
//                Section(header: CustomHeader(title: "First Section")) {
//                    ForEach(0..<10) { i in
//                        Text("Row \(i)")
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color.gray.opacity(0.1))
//                    }
//                }
//
//                Section(header: CustomHeader(title: "Second Section")) {
//                    ForEach(10..<20) { i in
//                        Text("Row \(i)")
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color.gray.opacity(0.1))
//                    }
//                }
//            }
//        }
//    }
//}
