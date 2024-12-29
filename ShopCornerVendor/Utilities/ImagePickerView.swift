//
//  ImagePickerView.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 11/12/24.
//


import SwiftUI
import PhotosUI
import UIKit

struct ImagePickerView<Content: View>: View {
    @State private var isShowingPhotoPicker = false
    @State private var isShowingCamera = false
    @State private var isShowingChoice = false
    
    // Provide content as a ViewBuilder. This allows the parent
    // to pass a closure that determines what to show based on selectedImage.
    @ViewBuilder var content: () -> Content
    var onImageSelected: (UIImage) -> Void
    
    var body: some View {
        
        content()
            
            .onTapGesture {
                // Show the dialog to choose camera or gallery.
                isShowingChoice = true
            }
            .confirmationDialog("Choose", isPresented: $isShowingChoice) {
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    Button("Open Camera") {
                        isShowingCamera = true
                    }
                }
                Button("Open Gallery") {
                    isShowingPhotoPicker = true
                }
            }
            .sheet(isPresented: $isShowingPhotoPicker) {
                PhotoPicker { image in
                    onImageSelected(image)
                }
            }
            .sheet(isPresented: $isShowingCamera) {
                CameraPicker { image in
                    onImageSelected(image)
                }
            }
        
        
        
        
    }
}

struct PhotoPicker: UIViewControllerRepresentable {
    var callback: ((UIImage) -> Void)
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else { return }
            
            provider.loadObject(ofClass: UIImage.self) { image, _ in
                DispatchQueue.main.async {
                    if let image = image as? UIImage{
                        self.parent.callback(image)
                    }
                }
            }
        }
    }
}

struct CameraPicker: UIViewControllerRepresentable {
    var callback: ((UIImage) -> Void)
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraPicker
        
        init(_ parent: CameraPicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
            if let image = info[.originalImage] as? UIImage {
                self.parent.callback(image)
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

