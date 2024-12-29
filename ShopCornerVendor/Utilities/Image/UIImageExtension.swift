//
//  UIImageExtension.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 17/12/24.
//


import UIKit

extension UIImage {
    /// Resizes the image to fit within the given size (e.g., 1080p) while maintaining aspect ratio.
    /// - Parameter maxSize: Maximum width and height (e.g., CGSize(width: 1920, height: 1080))
    /// - Returns: Resized UIImage
    func resized(toFit maxSize: CGSize = CGSize(width: 1920, height: 1080)) -> Data? {
        
        return compressImageToKBRange(self)
    }
    
    func compressImageToKBRange(
        _ image: UIImage,
        minKB: Int = 400,
        maxKB: Int = 500,
        to maxWidth: CGFloat = 1024
    ) -> Data? {
        let aspectRatio = image.size.height / image.size.width
        let newSize = CGSize(width: maxWidth, height: maxWidth * aspectRatio)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard var image = newImage else {
            return nil
        }
        // Convert KB to bytes
        let minBytes = minKB * 1024
        let maxBytes = maxKB * 1024
        
        // Start with highest quality (1.0 = no compression)
        var compressionQuality: CGFloat = 1.0
        
        // Get initial JPEG data
        guard var compressedData = image.jpegData(compressionQuality: compressionQuality) else {
            return nil
        }

        // Check if already in the desired range
        let initialSize = compressedData.count
        if initialSize >= minBytes && initialSize <= maxBytes {
            return compressedData
        }

        // If the image is bigger than maxBytes, keep compressing until within range or compression is too low
        while compressedData.count > maxBytes && compressionQuality > 0 {
            compressionQuality -= 0.05
            guard let newData = image.jpegData(compressionQuality: compressionQuality) else {
                return nil
            }
            compressedData = newData
        }
        
        // After compression, if it's below our minimum threshold, returning it anyway
        // (you can't "scale up" just by changing JPEG compression).
        return compressedData
    }
}
