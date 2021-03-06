//
//  Mission.swift
//  Moonshot
//
//  Created by David Burghoff on 28.11.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    var id: Int
    var launchDate: Date?
    var crew: [Crew]
    var description: String
    var displayName: String {
        "Apollo \(id)"
    }
    var image: String{
        "apollo\(id)"
    }
    var launchDateString: String{
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        }else {
            return "N/A"
        }
    }
    
}
