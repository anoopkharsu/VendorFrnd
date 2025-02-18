//
//  ViewExtension.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 07/12/24.
//

import SwiftUI

extension View {
    func roundedButtonStyle(radius: CGFloat) -> some View {
        self.frame(width: 40, height: 40)
            .background(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(style: .init(lineWidth: 1))
            )
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}


// Custom RoundedCorner Shape
struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
