//
//  NotificationManager.swift
//  ShopCorner
//
//  Created by Anoop Kharsu on 16/02/25.
//

import Foundation

class NotificationManager {
    enum NotificationKeys {
        static let notificationEvents = "notificationEvents"
        
    }
    static let shared = NotificationManager()
    let userDefaults = UserDefaults(suiteName: "group.com.anoopkharsu.shopcorner.vendor")
    
    
    func processAllPendingNotificationsEvents() {
        let events = (userDefaults?.array(forKey: NotificationKeys.notificationEvents) as? [String]) ?? []
        userDefaults?.removeObject(forKey: NotificationKeys.notificationEvents)
        events.forEach { event in
            self.processNotificationEvent(event)
        }
    }
    
    func processNotificationContentInForeground(_ content: [AnyHashable : Any]) {
        let noti = self.getNotificationData(content)
        if noti?.getNotificationType() == .newOrder {
            NotificationCenter.default.post(name: .newOrder, object: nil)
        }
        
    }
    
    func processNotificationContentInBackground(_ content: [AnyHashable : Any]) {
        let noti = self.getNotificationData(content)
        if let type = noti?.type {
            var events = (userDefaults?.array(forKey: NotificationKeys.notificationEvents) as? [String]) ?? []
            events.append(type)
            userDefaults?.set(events, forKey: NotificationKeys.notificationEvents)
        }
    }
    
    func processNotificationEvent(_ event: String) {
        let type = SCNotificationType(rawValue: event)
        if type == .newOrder {
            NotificationCenter.default.post(name: .newOrder, object: nil)
        }
    }
    
    
    
    func getNotificationData(_ content: [AnyHashable : Any]) -> SCNotificationInfoData? {
        let userInfo = content as? [String: Any]
        let data = try? JSONSerialization.data(withJSONObject: userInfo ?? [:], options: [])
        
        let noti  = try? JSONDecoder().decode(SCNotificationInfoData.self, from: data ?? Data())
        return noti
    }
    
}
