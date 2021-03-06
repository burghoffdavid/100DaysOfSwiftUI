//
//  Order.swift
//  CupcakeCorner
//
//  Created by David Burghoff on 03.12.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import Foundation

class Order: ObservableObject{
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    @Published var type = 0
    @Published var quantity = 3
    @Published var specialRequestEnabled = false{
        didSet{
            if specialRequestEnabled == false{
                extraFrosting = false
                extraSprinkles = false 
            }
        }
    }
    @Published var extraFrosting = false
    @Published var extraSprinkles = false
    
    @Published var name = ""
    @Published var streetAdress = ""
    @Published var city = ""
    @Published var zip = ""
}
