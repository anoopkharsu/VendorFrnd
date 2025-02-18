//
//  OrderViewModel.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 31/01/25.
//

import SwiftUI

class OrderViewModel: ObservableObject {
    var pendingOrders = [OrderModels.Order.Order]()
    var processingOrders = [OrderModels.Order.Order]()
    var othersOrders = [OrderModels.Order.Order]()
    
    var currentListOfOreders: [OrderModels.Order.Order] {
        switch selectedTab {
        case 0:
            return pendingOrders
        case 1:
            return processingOrders
        default:
            return othersOrders
        }
    }
    
    @Published var selectedTab = 0
    @Published var isLoading: Bool = false
    @Published var error: SCToastMessage?
    @Published var showError = false
    
    
    
    let tabs = ["Pending", "Processing", "Others"]
    let repository = OrderRepository()
    
    init() {
        loadAllOrders()
        NotificationCenter.default.addObserver(self, selector: #selector(loadAllOrders), name: .newOrder, object: nil)
    }
    
    @objc func loadAllOrders() {
        getPendingOrders()
        getProcessingOrders()
        self.getAllOtherOrders()
    }
    
    
    func getProcessingOrders() {
        self.isLoading = true
        let vendorId = AuthService.shared.getVendor().id
        repository.getVendorProcessingOrders(vendorId: vendorId) {[weak self] orders, error in
            self?.isLoading = false
            self?.processingOrders = orders ?? []
        }
    }
    
    func getPendingOrders() {
        self.isLoading = true
        let vendorId = AuthService.shared.getVendor().id
        repository.getVendorPendingOrders(vendorId: vendorId) {[weak self] orders, error in
            self?.isLoading = false
            self?.pendingOrders = orders ?? []
        }
    }
    
    func getAllOtherOrders() {
        self.isLoading = true
        let vendorId = AuthService.shared.getVendor().id
        repository.getVendorOtherOrders(vendorId: vendorId) {[weak self] orders, error in
            self?.isLoading = false
            self?.othersOrders = orders ?? []
        }
    }
    
    
    func acceptOrder(_ orderId: Int) {
        self.isLoading = true
        repository.markOrderToProcessing(orderId: orderId) {[weak self] _,error in
            self?.isLoading = false
            if let error {
                self?.error = SCToastMessage( message: error.localizedDescription, type: .error)
                self?.showError = true
            }
            self?.getPendingOrders()
            self?.getProcessingOrders()
            self?.getAllOtherOrders()
        }
    }
    
    
    func markShippedOrder(_ orderId: Int) {
        self.isLoading = true
        repository.markOrderToShipped(orderId: orderId) {[weak self] _,error in
            self?.isLoading = false
            if let error {
                self?.error = SCToastMessage( message: error.localizedDescription, type: .error)
                self?.showError = true
            } else {
                self?.getPendingOrders()
                self?.getProcessingOrders()
                self?.getAllOtherOrders()
            }
        }
    }
    
    func markDelivered(orderId: Int, otp: String) {
        isLoading = true
        SCNetwork.shared.requestData(.updateOrderStatustoDelivered(orderId: orderId, otp: otp)) {[weak self] (res: EmptyResponse?, error: Error?)  in
            self?.isLoading = false
            self?.isLoading = false
            if let error {
                self?.error = SCToastMessage( message: error.localizedDescription, type: .error)
                self?.showError = true
            } else {
                self?.getPendingOrders()
                self?.getProcessingOrders()
                self?.getAllOtherOrders()
            }
        }
    }
    
    func getBadgeCount(index: Int) -> Int {
        if index == 0 {
            return pendingOrders.count
        } else if index == 1 {
            return processingOrders.count
        } else {
            return othersOrders.count
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .newOrder, object: nil)
    }
    
}



