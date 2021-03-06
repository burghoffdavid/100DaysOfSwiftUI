//
//  HabitViewModel.swift
//  Habit Tracking
//
//  Created by David Burghoff on 29.11.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import Foundation

class HabitViewModel: ObservableObject {
    @Published var habits: [Habit] = []
 
    
    init() {
        habits = []
        loadHabits()
    }
    func saveHabits (){
        let encoder = JSONEncoder()
        let encodedHabits = try? encoder.encode(habits)
        let defaults = UserDefaults.standard
        defaults.set(encodedHabits, forKey: "Habits")
    }
    func loadHabits(){
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        
        if let encodedJson = defaults.data(forKey: "Habits"){
            let decodedData = try? decoder.decode([Habit].self, from: encodedJson)
            if let habits = decodedData{
                self.habits = habits
            }
        }
    }
}
