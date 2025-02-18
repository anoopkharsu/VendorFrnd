//
//  SelectCategoryModel.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 11/01/25.
//

import Foundation

struct SelectCategoryModel {
    var items: [Item] = []
    
    
    
    
    struct Item: Identifiable, Codable, Equatable {
        let id = UUID() // Unique ID for each subcategory
        let name: String
        let category: String
        let localName: String
        let hindiName: String
        let icon: String?
        let type: String // category,product
        let products: [Item]
        
        
        enum CodingKeys: String, CodingKey {
            case id
            case name = "english_name"
            case category
            case localName = "indian_name"
            case hindiName = "hindi_name"
            case icon
            case type
            case products
        }
    }
    
}
