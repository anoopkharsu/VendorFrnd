//
//  MarkOrderDeliveredAlertView.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 02/02/25.
//

import SwiftUI

struct MarkOrderDeliveredAlertView: View {
    let successCallback: () -> Void
    @Binding var showOTPAlert: Bool
    @Binding var otp: String
    
    var body: some View {
        VStack {
            TextField("Enter OTP", text: $otp)
            Button {
                successCallback()
            } label: {
                Text("Verify")
                    .fontWeight(.semibold)
                    .foregroundColor(.orange)
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.orange, lineWidth: 1)
                    )
                    .background(Color.white)
            }
        }
    }
}
