//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by David Burghoff on 01.12.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import SwiftUI
import Combine

class NetworkManager: ObservableObject {
    var didChange = PassthroughSubject<NetworkManager, Never>()
    
    var currentWeather = CurrentWeatherViewModel() {
        didSet {
            didChange.send(self)
        }
    }
    
    var dailyWeather = DailyWeatherViewModel() {
        didSet {
            didChange.send(self)
        }
    }
    
    let client = DarkSkyAPIClient()
    
    init() {
        client.getWeather(at: .newYorkCity) { weather, error in
            if let weather = weather {
                self.currentWeather = CurrentWeatherViewModel(model: weather.currently)
                self.dailyWeather = DailyWeatherViewModel(model: weather.daily)
            }
        }
    }
}
