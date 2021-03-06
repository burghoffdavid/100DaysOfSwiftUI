//
//  Weather.swift
//  WeatherApp
//
//  Created by David Burghoff on 01.12.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let currently: CurrentWeather
    let daily: DailyWeather
    
    init() {
        self.currently = CurrentWeather()
        self.daily = DailyWeather()
    }
}
