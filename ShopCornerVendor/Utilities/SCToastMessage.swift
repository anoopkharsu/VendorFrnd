//
//  SCError.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 02/12/24.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: SCToastMessage?
    let interval: TimeInterval
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented && message != nil {
                VStack {
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
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                            isPresented = false
                        }
                        
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .animation(.easeInOut, value: isPresented)
            }
        }
    }
}

extension View {
    func toast(
        isPresented: Binding<Bool>,
        message: SCToastMessage?,
        interval: TimeInterval = 2
    ) -> some View {
        self.modifier(ToastModifier( isPresented: isPresented, message: message, interval: interval))
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
