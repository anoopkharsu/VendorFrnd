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
        content
            .opacity( isLoading ? 0 : 1)
            .overlay {
                if isLoading {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                        }
                        LottieView(animationName: "Shimmer")
                            .frame(width: 100,height: 100)
                        Spacer()
                    }
                    .background(.white)
                }
            }
    }
}

extension View {
    func loading(isLoading loading: Bool) -> some View {
        self.modifier(LoadingIndicater(isLoading: loading))
    }
}

struct Shimmer: View {
    @State private var phase: CGFloat = -1
    
    var body: some View {
        
        GeometryReader { geometry in
            // Define a gradient with a bright band in the middle.
            
            let gradient = LinearGradient(
                gradient: Gradient(colors: [
                    Color.white.opacity(0.0),
                    Color.white.opacity(0.2),
                    Color.white.opacity(0.0)
                ]),
                startPoint: .leading,
                endPoint: .trailing
            )
            // The moving rectangle uses the gradient and is rotated slightly.
            Rectangle()
            
                .fill(gradient)
                .offset(x: phase * geometry.size.width)
        }
        .background(.gray.opacity(0.5))
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false)) {
                phase = 1
            }
        }
    }
}
