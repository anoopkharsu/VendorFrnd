//
//  OrderModels.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 31/01/25.
//

import Foundation

struct OrderModels {
    
    
    enum Order {
        struct Order: Codable, Identifiable {
            var id: Int {
                order_id
            }
            let order_id: Int
            let status: String
            let createdAt: String?
            let updatedAt: String?
            let cartId: Int
            let userId: Int
            let paymentMethod: String
            let paymentStatus: String
            let shippingAddress: Address?
            let deliveryCharges: Double
            let grandTotal: Double
            let estimatedDeliveryDate: String?
            let items: [Items]
            let notes: String?
            
            func getGrandTotal() -> String {
                return "₹"+String(format: "%.0f", grandTotal)
            }
            
            func createdTime() -> String {
                let isoFormatter = ISO8601DateFormatter()
                isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

                if let createdAt, let date = isoFormatter.date(from: createdAt) {
                    // Create a DateFormatter to format the date into 12-hour format with AM/PM
                    let timeFormatter = DateFormatter()
                    timeFormatter.dateFormat = "h:mm a"
                    timeFormatter.timeZone = TimeZone.current  // Convert to local timezone if needed

                    let formattedTime = timeFormatter.string(from: date)
                    return formattedTime  // Output: 11:00 AM (depends on your timezone)
                } else {
                    return "Invalid date format"
                }
            }
            
            enum CodingKeys:String, CodingKey {
                case order_id
                case status
                case createdAt = "created_at"
                case updatedAt = "updated_at"
                case cartId = "cart_id"
                case userId = "user_id"
                case paymentMethod = "payment_method"
                case paymentStatus = "payment_status"
                case shippingAddress = "shipping_address"
                case deliveryCharges = "delivery_fee"
                case grandTotal = "total_amount"
                case estimatedDeliveryDate = "estimated_delivery_date"
                case notes
                case items
            }
        }
        struct Address: Codable {
            var latitude: Double?
            var longitude: Double?
        }
        
        struct Items: Codable, Identifiable {
            var id: Int {
                order_item_id
            }
            let order_item_id: Int
            var product_name: String {product_snapshot.name}
            let quantity: Int
            let price: Double
            var unit: String {
                variant_snapshot.price_unit
            }
            let product_snapshot: Product
            let variant_snapshot: ProductVariant
            
            func getPriceString() -> String {
                return "₹"+String(format: "%.0f", price)
            }
            
            func getCostPriceString() -> String {
                return self.getPriceString()
            }
            
            func getQuantityString() -> String {
                return String(format: "%.0f", variant_snapshot.price_quantity) + unit + " x \(quantity)"
            }
        }
        
        struct Product: Codable {
            let image_url: String
            let name: String
        }
        
        struct ProductVariant: Codable {
            let price_value: Double
            let price_quantity: Double
            let price_unit: String
        }
    }
}



//struct SCOrder: Codable, Identifiable {
//    var currentStatus: SCOrderStatus { .init(rawValue: status)! }
//    var id: Int { order_id }
//    let order_id: Int
//    let vendor: SCVendor
//    let status: String // Current status of the order //Done
//    let createdAt: String // Date and time when the order was created
//    let updatedAt: String? // Date and time when the order was last updated
//    let cartId: Int // Associated cart ID
//    let userId: Int // User who placed the order
//    let paymentMethod: String // Payment details for the order
//    let paymentStatus: String //Done
//    let shippingAddress: SCAddress // Shipping address
//    let items: [OrderItem] // Items in the order
//    let deliveryCharges: Double // Shipping fee applied to the order
//    let grandTotal: Double // Final total amount to be paid
//    let estimatedDeliveryDate: String? // Estimated delivery date
//    let notes: String? // Additional notes provided by the user
//    let otp: String
//    
//    enum CodingKeys: String,CodingKey {
//        case order_id
//        case vendor
//        case status
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case cartId = "cart_id"
//        case userId = "user_id"
//        case paymentMethod = "payment_method"
//        case paymentStatus = "payment_status"
//        case shippingAddress = "shipping_address"
//        case items
//        case deliveryCharges = "delivery_fee"
//        case grandTotal = "total_amount"
//        case estimatedDeliveryDate = "estimated_delivery_date"
//        case notes
//        case otp
//    }
//    
//    
//    struct OrderItem: Codable, Identifiable {
//        var id: Int {orderItemId}
//        let orderItemId: Int
//        let orderId: Int
//        let productId: Int
//        let variantId: Int
//        let quantity: Int
//        let price: Double
//        let discount: Double
//        let customAttributes: [String: String]?
//        let createdAt: String
//        let updatedAt: String
//        let productName: String
//        let variantLabel: String?
//        let product: SCProduct
//        let variant: SCProductVariant
//        
//        enum CodingKeys: String, CodingKey {
//            case orderItemId = "order_item_id"
//            case orderId = "order_id"
//            case productId = "product_id"
//            case variantId = "variant_id"
//            case quantity
//            case price
//            case discount
//            case customAttributes = "custom_attributes"
//            case createdAt = "created_at"
//            case updatedAt = "updated_at"
//            case productName = "product_name"
//            case variantLabel = "variant_label"
//            case product
//            case variant
//        }
//    }
//
//}
//
//
//enum SCOrderStatus: String, Codable {
//    case pending = "pending"
//    case processing = "processing"
//    case shipped = "shipped"
//    case delivered = "delivered"
//    case cancelled = "cancelled"
//    case failed = "failed"
//    
//    /// Returns the current step for the order status
//    func getCurrentStep() -> OrderStep? {
//        switch self {
//        case .pending:
//            return OrderStep(title: "Waiting for vendor to accept", status: .active)
//        case .processing:
//            return OrderStep(title: "Processing your order", status: .active)
//        case .shipped:
//            return OrderStep(title: "Your order is on the way", status: .active)
//        case .delivered:
//            return OrderStep(title: "Your order has been delivered", status: .active)
//        case .cancelled:
//            return OrderStep(title: "Your order has been cancelled", status: .active)
//        case .failed:
//            return OrderStep(title: "Order processing failed", status: .active)
//        }
//    }
//    
//    /// Returns all steps for the order status
//    func getOrderSteps() -> [OrderStep] {
//        switch self {
//        case .pending:
//            return [
//                OrderStep(title: "Your order has been received", status: .active),
//                OrderStep(title: "Your order has been accepted", status: .pending),
//                OrderStep(title: "Packing/Preparing your order", status: .pending),
//                OrderStep(title: "Your order has been picked up for delivery", status: .pending),
//                OrderStep(title: "Order arriving soon!", status: .pending, last: true)
//            ]
//        case .processing:
//            return [
//                OrderStep(title: "Your order has been received", status: .completed),
//                OrderStep(title: "Your order has been accepted", status: .completed),
//                OrderStep(title: "Packing/Preparing your order", status: .active),
//                OrderStep(title: "Your order has been picked up for delivery", status: .pending),
//                OrderStep(title: "Order arriving soon!", status: .pending, last: true)
//            ]
//        case .shipped:
//            return [
//                OrderStep(title: "Your order has been received", status: .completed),
//                OrderStep(title: "Your order has been accepted", status: .completed),
//                OrderStep(title: "Packing/Preparing your order", status: .completed),
//                OrderStep(title: "Your order has been picked up for delivery", status: .active),
//                OrderStep(title: "Order arriving soon!", status: .pending, last: true)
//            ]
//        case .delivered:
//            return [
//                OrderStep(title: "Your order has been received", status: .completed),
//                OrderStep(title: "Your order has been accepted", status: .completed),
//                OrderStep(title: "Packing/Preparing your order", status: .completed),
//                OrderStep(title: "Your order has been picked up for delivery", status: .completed),
//                OrderStep(title: "Order arriving soon!", status: .completed, last: true)
//            ]
//        case .cancelled:
//            return [
//                OrderStep(title: "Your order has been received", status: .completed),
//                OrderStep(title: "Packing/Preparing your order", status: .pending),
//                OrderStep(title: "Your order has been cancelled", status: .completed, last: true)
//            ]
//        case .failed:
//            return [
//                OrderStep(title: "Your order has been received", status: .completed),
//                OrderStep(title: "Packing/Preparing your order", status: .pending),
//                OrderStep(title: "Payment failed or order could not be processed", status: .completed, last: true)
//            ]
//        }
//    }
//}
//
///// Represents a step in the order's progress
//struct OrderStep: Identifiable {
//    var id: String { self.title }
//    let title: String
//    var status: Status
//    var last: Bool = false
//    
//    enum Status {
//        case completed
//        case pending
//        case active
//        case failed
//    }
//}
//
//
//
//
//struct PaymentDetails: Codable {
//    let paymentMethod: String // Payment method (e.g., CREDIT_CARD, PAYPAL, POD)
//    let paymentStatus: PaymentStatus // Payment status (e.g., PAID, PENDING, FAILED)
//    let paymentId: String? // Payment ID from the payment gateway (if applicable)
//    let transactionDate: String? // Date and time of the transaction
//}
//
//// MARK: - PaymentStatus Enum
//enum PaymentStatus: String, Codable {
//    case paid = "Paid"
//    case pending = "Pending"
//    case failed = "Failed"
//}
