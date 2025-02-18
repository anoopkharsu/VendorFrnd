
//
//  UIViewControllerExtension.swift
//  ShopCorner
//
//  Created by Anoop Kharsu on 26/12/24.
//

import UIKit
import SwiftUI

extension UIViewController {
    func addSwiftUIView<T: View>(view swiftUIView: T, transprent: Bool = false)  {
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        
        // Add the hostingController as a child
        addChild(hostingController)
        view.addSubview(hostingController.view)
        if transprent {
            hostingController.view.backgroundColor = .clear
        }
        // Set up the hostingController's view constraints
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Notify the hostingController that it was added
        hostingController.didMove(toParent: self)
    }
}
