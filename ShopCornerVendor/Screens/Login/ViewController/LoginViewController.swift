//
//  LoginViewController.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 02/12/24.
//

import UIKit
import SwiftUI

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginView = LoginScreenView()
        let hostingController = UIHostingController(rootView: loginView)
        
        
        // Add the hostingController as a child
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
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
