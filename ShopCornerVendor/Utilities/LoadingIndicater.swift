//
//  LoadingIndicater.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 05/12/24.
//

import SwiftUI
import UIKit

struct LoadingIndicater: ViewModifier {
    let isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isLoading {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        ZStack {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .scaleEffect(2)
                            
                        }
                        
                        Spacer()
                    }
                    Spacer()
                }
                .background(.gray.opacity(0.2))
            }
        }
    }
}

extension View {
    func loading(isLoading loading: Bool) -> some View {
        self.modifier(LoadingIndicater(isLoading: loading))
    }
}

