//
//  CachedImageView.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 17/12/24.
//
import SwiftUI

struct CachedImageView: View {
    @StateObject private var loader = PersistentImageLoader()
    let url: String?
    let placeholder: Image
    
    init(url: String?, placeholder: Image = Image(systemName: "photo")) {
        self.url = url
        self.placeholder = placeholder
    }
    
    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                placeholder
                    .resizable()
                    .scaledToFill()
            }
        }
        
        .onAppear {
            if let stringUrl = url, let url = URL(string: stringUrl){
                loader.loadImage(from: url)
            }
        }
        .onChange(of: url) { newURL in
            // Reload image when URL changes
            if let stringUrl = newURL, let url = URL(string: stringUrl){
                loader.loadImage(from: url)
            }
        }
        .onDisappear {
            loader.cancel()
        }
    }
}
