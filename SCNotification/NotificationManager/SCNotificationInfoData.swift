//
//  SCNotificationInfoData.swift
//  ShopCorner
//
//  Created by Anoop Kharsu on 16/02/25.
//


struct SCNotificationInfoData: Codable {
    var type: String?
    
    
    
    
    
    func getNotificationType() -> SCNotificationType? {
        return SCNotificationType(rawValue: type ?? "")
    }
}

enum SCNotificationType: String {
    case newOrder = "new_order"
    
}
