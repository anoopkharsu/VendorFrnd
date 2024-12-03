//
//  LoginScreenView.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 02/12/24.
//

import SwiftUI

struct LoginScreenView: View {
    @State var tt = ""
    @ObservedObject var model = LoginViewModel()
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Shop Corner")
                        .font(.system(size: 26,weight: .heavy))
                        .foregroundStyle(.white)
                    Spacer()
                }
                Spacer()
                HStack {
                    Text("Sign in")
                        .font(.system(size: 16,weight: .heavy))
                        .foregroundStyle(.white)
                    Spacer()
                }
            }
            .padding()
            .background(.blue)
            
            VStack {
                FloatingLabelTextField(
                    text: $model.loginModel.phoneNumber,
                    title: "Phone Number",
                    placeholder: "Enter your phone number"
                )
            }
            .padding()
        }
        .toast(message: model.loginModel.error)
        
    }
}

struct FloatingLabelTextField: View {
    @State private var isFocused: Bool = false
    @Binding var text: String
    
    var title: String
    var placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // Title that floats to the top
            Text(title)
                .font(.system(size: 14))

            // TextField with a placeholder
            TextField(placeholder, text: $text, onEditingChanged: { focused in
                isFocused = focused
            })
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isFocused ? Color.accentColor : Color.gray, lineWidth: 1)
            )
            Spacer()
                .frame(height: 16)
            
            Button {
                
            } label: {
                Spacer()
                Text("Send OTP")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding()
            .background(.green)
            .clipShape(.rect(cornerRadius: 8))
            
        }
        .padding(.vertical, 8)
    }
}


#Preview {
    LoginScreenView()
}
