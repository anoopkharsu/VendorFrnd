//
//  LoginScreenView.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 02/12/24.
//

import SwiftUI

struct LoginScreenView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationView {
                VStack(spacing: 0) {
                    headerView
                    contentView
                    NavigationLink(
                        destination: OTPVerificationScreenView(phoneNumber: viewModel.loginModel.countryCode + viewModel.loginModel.phoneNumber),
                        isActive: $viewModel.navigateToOTPVerification
                    ) {
                        EmptyView()
                    }
                }
                .navigationBarHidden(true)
            }
        }
        .loading(isLoading: self.viewModel.screenState == .showActivityIndicator)
        .toast(isPresented: $viewModel.presentToast, message: viewModel.loginModel.error)
    }
    
    // MARK: - Header View
    
    private var headerView: some View {
        VStack {
            HStack {
                Text("app.title".localized)
                    .font(.system(size: 26, weight: .heavy))
                    .foregroundColor(.white)
                Spacer()
            }
            Spacer()
            HStack {
                Text("login.sign.in".localized)
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .padding()
        .background(Color.blue)
    }
    
    // MARK: - Content View
    
    private var contentView: some View {
        VStack(spacing: 16) {
            PhoneNumberInputView(selectedCountryCode: $viewModel.loginModel.countryCode, phoneNumber: $viewModel.loginModel.phoneNumber)
            GreenButton(title: "button.send.otp".localized) {
                viewModel.getOtp()
            }
        }
        .padding()
    }
}

struct GreenButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .cornerRadius(8)
        }
    }
}


//
//#Preview {
//    LoginScreenView()
//}
