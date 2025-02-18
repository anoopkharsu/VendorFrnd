//
//  OTPVerificationScreenView.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 04/12/24.
//

import SwiftUI

struct OTPVerificationScreenView: View {
    @StateObject var viewModel: OTPVerificationViewModel
    @Environment(\.dismiss) var dismiss
    let phoneNumber: String

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button {
                    dismiss()
                }label: {
                    Image(systemName: "chevron.backward")
                        .font(.title)
                        .frame(width: 40,height: 40)
                        .roundedButtonStyle(radius: 20)
                }
                Spacer()
            }
            Spacer()
            Text("otp.verify".localized)
                .font(.title)
                .padding(.top)

            Text("otp.sent.to".localized + " \(phoneNumber)")
                .font(.subheadline)
                .foregroundColor(.gray)

            OTPInputView(otpFields: $viewModel.otpCode)
            GreenButton(title: "button.verify".localized) {
                viewModel.verifyOTP()
            }

            Spacer().frame(height: 26)
        }
        .padding()
        .toast(isPresented: $viewModel.presentToast, message: viewModel.toastMessage)
        .navigationBarHidden(true)
        .loading(isLoading: viewModel.verificationState == .verifying)
    }
}
