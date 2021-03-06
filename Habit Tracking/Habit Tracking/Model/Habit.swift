//
//  Habit.swift
//  Habit Tracking
//
//  Created by David Burghoff on 29.11.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import Foundation

struct Habit: Identifiable, Codable{
    var id = UUID()
    var title: String
    var description: String
    var unit: String
    var count: Int
}
