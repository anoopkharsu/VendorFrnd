//
//  OrdersViewList.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 31/01/25.
//


import SwiftUI

struct OrdersViewList: View {
    let orders: [OrderModels.Order.Order]
    let acceptOrder: (Int) -> Void
    let assignForDelivery: (Int) -> Void
    let shareLocation: (OrderModels.Order.Order) -> Void
    let markDelivered: (Int, String) -> Void
    
    var body: some View {
        List {
            if orders.isEmpty {
                VStack {
                    Image(systemName: "tray.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                    Text("No Orders Available")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 1)
                .listRowSeparator(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            } else {
                ForEach(orders) { order in
                    OrderListCellView(order: order, acceptOrder: acceptOrder, assignForDelivery: assignForDelivery, shareLocation: shareLocation, markDelivered: markDelivered)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 1)
                        .listRowSeparator(.hidden)
                }
            }
        }
        .listStyle(.plain)
        
        
    }
}

struct OrderListCellView: View {
    @State var showOTPAlert: Bool = false
    @State var otp: String = ""
    
    let order: OrderModels.Order.Order
    let acceptOrder: (Int) -> Void
    let assignForDelivery: (Int) -> Void
    let shareLocation: (OrderModels.Order.Order) -> Void
    let markDelivered: (Int, String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            // Top row: "Preparing" label and time
            HStack {
                Text(order.status)
                    .font(.caption)
                    .foregroundColor(.orange)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.orange.opacity(0.15))
                    )
                
                Spacer()
                
                Text(order.createdTime())
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            // Food name row with thumbnail
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 12) {
                    ForEach(order.items) { item in
                        VStack(alignment: .leading, spacing: 8) {
                            AsyncImage(url: URL(string: item.product_snapshot.image_url)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                // Placeholder while loading the image
                                Color.gray
                            }
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.product_name)
                                    .font(.headline)
                                Text(item.getQuantityString())
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text(item.getCostPriceString())
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            
            HStack {
                Spacer()
                Text(order.getGrandTotal())
                    .fontWeight(.semibold)
            }
            
            if order.status == "pending" {
                HStack {
                    Text("Items Out of stock")
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.orange, lineWidth: 1)
                        )
                        .background(Color.white)
                        .onTapGesture {
                            
                        }
                    
                    Text("Accept Order")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(8)
                        .onTapGesture {
                            acceptOrder(order.id)
                        }
                        
                    
                }
            } else if order.status == "processing" {
                HStack {
                    Text("Cancel Order")
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.orange, lineWidth: 1)
                        )
                        .background(Color.white)
                        .onTapGesture {
                            
                        }
                    
                    Text("Assign For Delivery")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(8)
                        .onTapGesture {
                            assignForDelivery(order.id)
                        }
                }
            } else if order.status == "shipped" {
                HStack {
                    Text("Mark Delivered")
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.orange, lineWidth: 1)
                        )
                        .background(Color.white)
                        .onTapGesture {
                            showOTPAlert = true
                        }
                        .alert("OTP", isPresented: $showOTPAlert, presenting: otp) { otp in
                            MarkOrderDeliveredAlertView( successCallback: {
                                self.markDelivered(order.id, self.otp)
                            }, showOTPAlert: $showOTPAlert, otp: $otp)
                        }
                    
                    Text("Delivery Location")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(8)
                        .onTapGesture {
                            shareLocation(order)
                        }
                }
            }
        }
    }
}

