//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by David Burghoff on 01.12.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import Foundation

struct DailyWeather: Codable {
    let data: [Data]
    
    struct Data: Codable {
        let time: Double
        let temperatureHigh: Double
        let temperatureLow: Double
        let icon: String
    }
    
    init() {
        self.data = [Data]()
    }
}
