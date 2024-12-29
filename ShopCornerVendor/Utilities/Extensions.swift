//
//  Extensions.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 19/12/24.
//

import Foundation

extension Encodable {
    func toDictionary() throws -> [String: Any] {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
        
        guard let dictionary = jsonObject as? [String: Any] else {
            throw NSError(domain: "Invalid Conversion", code: 0, userInfo: nil)
        }
        return dictionary
    }
    
    func encodeToJSON(from dictionary: [String: Any]) -> Data? {
        do {
            // Convert the dictionary to JSON data
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            
            // Convert the JSON data to a string (for printing)
            return jsonData
        } catch {
            print("Error encoding dictionary to JSON: \(error.localizedDescription)")
        }
        return nil
    }

 
}

extension Decodable {
    init(fromDictionary dictionary: [String: Any]) throws {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
}


