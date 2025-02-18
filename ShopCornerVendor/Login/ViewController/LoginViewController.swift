//
//  LoginViewController.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 02/12/24.
//

import UIKit
import SwiftUI
import Combine

class LoginViewController: UIViewController {
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AuthService.shared.$authToken
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] token in
                if token != nil {
                    self?.goToHomePage()
                }
            }
            .store(in: &cancellables)
           
        
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
    
    func goToHomePage() {
        guard let window = SceneDelegate.shared?.window else { return }
        
        let tabBar = SCTabBarController()
        let navigation = UINavigationController(rootViewController: tabBar)
        
        
        
        
        UIView.transition(with: window, duration: 0.5, options: .curveEaseInOut, animations: {
            window.rootViewController = navigation
        }, completion: nil)
    }

}
