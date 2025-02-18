//
//  QRCodeView.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 13/02/25.
//


import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    let urlString: String
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        Group {
            if let qrImage = generateQRCode(from: urlString) {
                Image(uiImage: qrImage)
                    .resizable()
                    .interpolation(.none) // preserves the sharpness of the QR code
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            } else {
                Text("Invalid URL or unable to generate QR Code.")
                    .foregroundColor(.red)
            }
        }
    }
    
    private func generateQRCode(from string: String) -> UIImage? {
        // Convert the string into Data (UTF-8 encoding)
        let data = Data(string.utf8)
        
        // Configure the filter with the data
        filter.setValue(data, forKey: "inputMessage")
        // Optionally set the error correction level: L, M, Q, or H (higher levels produce denser codes)
        filter.setValue("H", forKey: "inputCorrectionLevel")
        
        // Get the output image
        if let outputImage = filter.outputImage {
            // Scale the image up for clarity (since the default output is small)
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            let scaledImage = outputImage.transformed(by: transform)
            
            // Convert the CIImage into a CGImage, then into a UIImage
            if let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        return nil
    }
}
