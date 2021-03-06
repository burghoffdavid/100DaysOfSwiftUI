//
//  OrderModel.swift
//  CupcakeCorner
//
//  Created by David Burghoff on 03.12.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import Foundation

struct OrderModel: Codable{
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    var type = 0
    var quantity = 3
    var specialRequestEnabled = false{
        didSet{
            if specialRequestEnabled == false{
                extraFrosting = false
                extraSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var extraSprinkles = false
    
    var name = ""
    var streetAdress = ""
    var city = ""
    var zip = ""
    var hasValidAdress: Bool{
        if name.isEmpty || streetAdress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    var cost: Double{
        var cost = Double(quantity * 2)
        cost += Double(type) / 2
        if extraFrosting{
            cost += Double(quantity)
        }
        if extraSprinkles{
            cost += Double(quantity) / 2
        }
        return cost
    }
}
