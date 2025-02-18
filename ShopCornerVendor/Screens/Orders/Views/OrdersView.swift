//
//  OrdersView.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 31/01/25.
//

import SwiftUI

struct OrdersView: View {
    @StateObject var viewModel = OrderViewModel()
    let shareLocation: (Double,Double) -> Void

    
    let orders = [
        ("Tomato Basil Pasta", 1),
        ("Butternut Squash & Sage Risotto", 2)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(viewModel.tabs[viewModel.selectedTab])
                    .fontWeight(.semibold)
                Spacer()
                Button {
                    viewModel.loadAllOrders()
                } label: {
                    Image(systemName: "arrow.triangle.2.circlepath.circle")
                }
            }
            .padding(.horizontal)
            .padding(.bottom,8)
            
            OrdersViewList(orders: viewModel.currentListOfOreders, acceptOrder: {orderId in
                self.viewModel.acceptOrder( orderId)
            }, assignForDelivery: { orderId in
                self.viewModel.markShippedOrder(orderId)
            }, shareLocation: { order in
                shareLo(latitude: order.shippingAddress?.latitude, longitude: order.shippingAddress?.longitude)
            }, markDelivered: { orderId, otp in
                self.viewModel.markDelivered(orderId: orderId, otp: otp)
                
            })
            
            Spacer(minLength: 0)
            scrollableTabs
                
        }
        .loading(isLoading: self.viewModel.isLoading)
        .toast(isPresented: $viewModel.showError, message: self.viewModel.error)
        
    }
    
    func shareLo(latitude: Double?, longitude: Double?) {
        if let latitude, let longitude {
            shareLocation(latitude, longitude)
        }
    }
    // MARK: - Scrollable Tabs View
    private var scrollableTabs: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(viewModel.tabs.indices, id: \.self) { index in
                    ZStack(alignment: .topTrailing) {
                        Text(viewModel.tabs[index])
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                ZStack {
                                    Capsule()
                                        .fill(index == viewModel.selectedTab ? Color.accentColor.opacity(0.2) : Color.clear)
                                    Capsule()
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                }
                            )
                            .onTapGesture {
                                viewModel.selectedTab = index
                            }
                        
                        // Check if there's a count for the tab and display a badge
                        let badgeCount = viewModel.getBadgeCount(index: index)
                        if badgeCount > 0 {
                            Text("\(badgeCount)")
                                .font(.system(size: 12))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(6)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: 10, y: -10) // Position the badge
                        }
                    }
                }
            }
            .padding()
        }
    }
}


import UIKit

struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // Nothing to update.
    }
}
