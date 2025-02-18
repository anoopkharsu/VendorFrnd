//
//  SCTabBarController.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 07/12/24.
//

import UIKit

class SCTabBarController: UITabBarController {
    weak static var shared: SCTabBarController?
    weak var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Self.shared = self
        if AuthService.shared.isVenderLoaded() {
            setupTabs()
        } else {
            activityIndicator = showActivityIndicator()
            AuthService.shared.saveVendor {[weak self] saved in
                self?.hideActivityIndicator(self?.activityIndicator)
                if saved {
                    self?.setupTabs()
                } else {
                    self?.showError(message: "Unable to load Details")
                }
            }
        }
    }
    
    
    
    
    private func setupTabs() {
        // Create view controllers for each tab
        let dashboardViewController = DashboardViewController()
        dashboardViewController.tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(systemName: "square.grid.2x2.fill"), tag: 0)
        
        let ordersViewController = OrdersViewController()
        ordersViewController.tabBarItem = UITabBarItem(title: "Orders", image: UIImage(systemName: "list.bullet"), tag: 1)
        
        let productsViewController = ProductsViewController()
        productsViewController.tabBarItem = UITabBarItem(title: "Products",image: UIImage(systemName: "suitcase.cart"), tag: 2)
        
        let settingsViewController = SettingsViewController()
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 3)
        
        // Add them to the tab bar controller
        self.viewControllers = [dashboardViewController,ordersViewController,productsViewController,settingsViewController]
        
    }
    func showActivityIndicator(style: UIActivityIndicatorView.Style = .large, color: UIColor = .gray) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.color = color
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
        return activityIndicator
    }
    
    // Function to hide a given activity indicator
    func hideActivityIndicator(_ activityIndicator: UIActivityIndicatorView?) {
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
    }
    let errorMessageViewTag = 1000
    func showError(message: String) {
        // Check if an error message view is already present
        if let existingErrorView = view.viewWithTag(self.errorMessageViewTag) {
            // Update the message if needed
            if let label = existingErrorView.subviews.compactMap({ $0 as? UILabel }).first {
                label.text = message
            }
            return
        }
        
        // Create the error message view
        let errorMessageView = UIView()
        errorMessageView.backgroundColor = UIColor.red.withAlphaComponent(0.9)
        errorMessageView.translatesAutoresizingMaskIntoConstraints = false
        errorMessageView.tag = self.errorMessageViewTag
        errorMessageView.alpha = 0 // Start hidden
        
        // Create the error message label
        let errorMessageLabel = UILabel()
        errorMessageLabel.textColor = .white
        errorMessageLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.text = message
        
        // Add label to the error message view
        errorMessageView.addSubview(errorMessageLabel)
        
        // Add error message view to the main view
        view.addSubview(errorMessageView)
        
        // Set up constraints for errorMessageView
        NSLayoutConstraint.activate([
            errorMessageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            errorMessageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorMessageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Set up constraints for errorMessageLabel
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalTo: errorMessageView.topAnchor, constant: 10),
            errorMessageLabel.bottomAnchor.constraint(equalTo: errorMessageView.bottomAnchor, constant: -10),
            errorMessageLabel.leadingAnchor.constraint(equalTo: errorMessageView.leadingAnchor, constant: 16),
            errorMessageLabel.trailingAnchor.constraint(equalTo: errorMessageView.trailingAnchor, constant: -16)
        ])
        
        // Animate the error message view
        UIView.animate(withDuration: 0.5, animations: {
            errorMessageView.alpha = 1
        })
        
        // Optionally, auto-dismiss after a delay
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {[weak self] in
//            self?.hideError()
//        }
    }
    
    /// Hides the error message banner.
    func hideError() {
        if let errorMessageView = view.viewWithTag(self.errorMessageViewTag) {
            UIView.animate(withDuration: 0.5, animations: {
                errorMessageView.alpha = 0
            }) { _ in
                errorMessageView.removeFromSuperview()
            }
        }
    }
    
}
