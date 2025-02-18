//
//  OTPInputView.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 04/12/24.
//

import SwiftUI
import UIKit

// Custom UITextField to detect delete key press
class CustomTextField: UITextField {
    var onDeleteBackward: (() -> Void)?

    override func deleteBackward() {
        super.deleteBackward()
        onDeleteBackward?()
    }
}

// UIViewRepresentable to use CustomTextField in SwiftUI
struct CustomTextFieldRepresentable: UIViewRepresentable {
    @Binding var text: String
    var onDeleteBackward: () -> Void

    func makeUIView(context: Context) -> CustomTextField {
        let textField = CustomTextField()
        textField.delegate = context.coordinator
        textField.onDeleteBackward = onDeleteBackward
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.textContentType = .oneTimeCode
        return textField
    }

    func updateUIView(_ uiView: CustomTextField, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomTextFieldRepresentable

        init(_ parent: CustomTextFieldRepresentable) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async {[weak self] in
                self?.parent.text = textField.text ?? ""
            }
        }
    }
}

// Usage in your OTPInputView
struct OTPInputView: View {
    @Binding var otpFields: [String]
    @FocusState private var focusIndex: Int?

    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<6, id: \.self) { index in
                CustomTextFieldRepresentable(text: $otpFields[index], onDeleteBackward: {
                    if otpFields[index].isEmpty && index > 0 {
                        focusIndex = index - 1
                    }
                })
                .frame(width: 40, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .focused($focusIndex, equals: index)
                .onChange(of: otpFields[index]) { newValue in
                    if newValue.count > 1 {
                        otpFields[index] = String(newValue.last!)
                    }
                    if !newValue.isEmpty {
                        if index < 5 {
                            focusIndex = index + 1
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.async {
                        if index == 0 {
                            self.focusIndex = 0
                        }
                    }
                }
            }
        }
        .padding()
    }
}


//struct ContentView: View {
//    @State var otpFields = ["","","","","",""]
//    var body: some View {
//        OTPInputView(otpFields: $otpFields)
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
