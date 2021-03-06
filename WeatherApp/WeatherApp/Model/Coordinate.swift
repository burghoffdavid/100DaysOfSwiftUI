//
//  Coordinate.swift
//  WeatherApp
//
//  Created by David Burghoff on 01.12.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import Foundation

struct Coordinate {
    let latitude: Double
    let longitude: Double
}

extension Coordinate: CustomStringConvertible {
    var description: String {
        return "\(latitude),\(longitude)"
    }
    
    static var newYorkCity: Coordinate {
        return Coordinate(latitude: 40.7128, longitude: -74.0060)
    }
}
