//
//  DarkSkyError.swift
//  WeatherApp
//
//  Created by David Burghoff on 01.12.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import Foundation

enum DarkSkyError: Error {
    case requestFailed
    case responseUnsuccessful(statusCode: Int)
    case invalidData
    case jsonParsingFailure
    case invalidURL
}
