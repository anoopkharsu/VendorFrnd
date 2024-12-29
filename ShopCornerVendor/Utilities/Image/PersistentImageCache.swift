//
//  PersistentImageCache.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 17/12/24.
//


import SwiftUI
import Combine

class PersistentImageCache {
    static let shared = PersistentImageCache()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL

    private init() {
        // Get Caches directory for storing images
        if let cacheDir = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first {
            cacheDirectory = cacheDir.appendingPathComponent("ImageCache")
        } else {
            fatalError("Unable to get cache directory")
        }

        // Create directory if it doesn't exist
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        }
    }

    /// Generate a unique file name for a URL
    private func fileName(for url: URL) -> String {
        return url.absoluteString.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? UUID().uuidString
    }

    /// Save an image to disk
    func saveImage(_ image: UIImage, for url: URL) {
        let fileURL = cacheDirectory.appendingPathComponent(fileName(for: url))
        if let data = image.jpegData(compressionQuality: 1.0) {
            try? data.write(to: fileURL)
        }
    }

    /// Load an image from disk
    func loadImage(for url: URL) -> UIImage? {
        let fileURL = cacheDirectory.appendingPathComponent(fileName(for: url))
        if let data = try? Data(contentsOf: fileURL) {
            return UIImage(data: data)
        }
        return nil
    }

    /// Check if image exists on disk
    func imageExists(for url: URL) -> Bool {
        let fileURL = cacheDirectory.appendingPathComponent(fileName(for: url))
        return fileManager.fileExists(atPath: fileURL.path)
    }
}