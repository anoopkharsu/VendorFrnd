//
//  SCNetwork.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 07/12/24.
//

import Foundation

class SCNetwork {
    static let shared = SCNetwork()
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        
        self.session = session
    }
    struct SCResponse<T: Codable>: Codable {
        var message: String?
        var data: T?
    }
    
    
    func uploadImage(to url: URL, imageData: Data, callback: @escaping (Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type") // Adjust content type

        let task = URLSession.shared.uploadTask(with: request, from: imageData) { ss, dd, error in
            DispatchQueue.main.async {
                callback(error)
            }
        }
        task.resume()
    }
    
    func requestData<T: Codable>(_ endpoint: SCServices, callback: @escaping (T?,  Error?) -> Void) {
        let request = endpoint.makeRequest()
        let task = session.dataTask(with: request) { data, response, error in
            #if DEBUG
                if let data {
                    self.printData(data: data)
                }
            #endif
            DispatchQueue.main.async {
                if let error {
                    #if DEBUG
                        print(error)
                    #endif
                    callback(nil,error)
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    callback(nil,SCError.init(localizedDescription: "Bad Response"))
                    return
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    #if DEBUG
                        print(httpResponse)
                    #endif
                    callback(nil,SCError.init(localizedDescription: "Status Code \(httpResponse.statusCode)"))
                    return
                }
                
                if let data {
                    do {
                        let response = try JSONDecoder().decode(SCResponse<T>.self, from: data)
                        callback(response.data,nil)
                    } catch let error {
                        print(error)
                        callback(nil,error)
                    }
                } else {
                    callback(nil,SCError.init(localizedDescription: "Data not found"))
                }
            }
        }
        task.resume()
    }
    
    func printData(data: Data) {
        do {
            // Step 1: Deserialize JSON Data to a JSON Object
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            // Step 2: Serialize JSON Object to Data with Pretty Print
            let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            
            // Step 3: Convert Pretty Data to String
            if let prettyString = String(data: prettyData, encoding: .utf8) {
                print("Pretty-Printed JSON:\n\(prettyString)")
            } else {
                print("Failed to convert pretty data to String.")
            }
            
        } catch {
            print("Error parsing or pretty-printing JSON: \(error.localizedDescription)")
        }
    }
}
