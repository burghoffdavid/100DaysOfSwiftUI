//
//  Trivia.swift
//  TriviaDatesAndMath
//
//  Created by David Burghoff on 25.11.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import Foundation

struct Trivia: Codable, Identifiable{
    public var id: String {
        return text + type
    }
    public var text: String
    public var found: Bool
    public var number: Float?
    public var type: String
    public var date: String?
    public var year: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        case found = "found"
        case number = "number"
        case type = "type"
        case date = "date"
        case year = "year"
    }
    
}
