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
}
