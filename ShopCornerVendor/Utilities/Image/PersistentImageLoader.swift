//
//  PersistentImageLoader.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 17/12/24.
//
import SwiftUI
import Combine

class PersistentImageLoader: ObservableObject {
    @Published var image: UIImage? = nil
    private var cancellable: AnyCancellable?

    func loadImage(from url: URL) {
        // 1. Check if the image exists on disk
        if let cachedImage = PersistentImageCache.shared.loadImage(for: url) {
            self.image = cachedImage
            print("Loaded image from disk cache")
            return
        } else {
            self.image = nil
        }

        // 2. If not, download the image
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] downloadedImage in
                guard let self = self, let image = downloadedImage else { return }
                // Save to disk cache
                PersistentImageCache.shared.saveImage(image, for: url)
                self.image = image
                print("Downloaded and saved image to disk cache")
            }
    }

    func cancel() {
        cancellable?.cancel()
    }
}
