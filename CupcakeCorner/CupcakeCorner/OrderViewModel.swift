//
//  OrderViewModel.swift
//  CupcakeCorner
//
//  Created by David Burghoff on 03.12.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import Foundation
import SwiftUI

class OrderViewModel: ObservableObject, Codable{
    
    enum CodingKeys: CodingKey {
        case order
    }
    @Published var order = OrderModel()

    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        order = try container.decode(OrderModel.self, forKey: .order)
    }
    init(){
        
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(order, forKey: .order)
    }
    func placeOrder(){
        guard let encoded = try? JSONEncoder().encode(self) else {
            print("Failed to encode OrderVM")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data else {
                print("No Data in Response: \(error?.localizedDescription ?? "Unknown Error").")
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(OrderViewModel.self, from: data) {
                self.orderMessage = "Your order for \(decodedOrder.order.quantity)x \(OrderModel.types[decodedOrder.order.type].lowercased()) cupcakes is on its way!"
                self.showAlert = true
            } else {
                print("Invalid response from server")
            }
            
        }.resume()
    }
}
