//
//  SCError.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 02/12/24.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    var isPresented: Bool {
        message != nil
    }
    let message: SCToastMessage?
    
    func body(content: Content) -> some View {
        content
            .overlay(
                VStack {
                    if isPresented {
                        HStack {
                            Text(message!.message)
                                .font(.subheadline)
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        .padding()
                        .background(message!.type.backgroundColor)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .padding(.top, 20) // Adjusts the toast position
                    }
                    Spacer()
                }
                    .padding(.horizontal)
                .animation(.easeInOut, value: isPresented)
            
            )
    }
}

extension View {
    func toast(
        message: SCToastMessage?
    ) -> some View {
        self.modifier(ToastModifier( message: message))
    }
}

struct SCToastMessage {
    var message: String
    let type: ErrorType
    
    enum ErrorType {
        case error
        case warning
        case success
        case none
        
        var backgroundColor: Color {
            switch self {
            case .error:
                return Color(red: 231/255, green: 76/255, blue: 60/255) // Bright Red (#E74C3C)
            case .warning:
                return Color(red: 241/255, green: 196/255, blue: 15/255) // Yellow (#F1C40F)
            case .success:
                return Color(red: 39/255, green: 174/255, blue: 96/255) // Green (#27AE60)
            case .none:
                return Color.clear // Transparent
            }
        }
    }
}
