//
//  AstronautViewModel.swift
//  Moonshot
//
//  Created by David Burghoff on 28.11.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import Foundation

class AstronautViewModel: ObservableObject{
    @Published var astronauts:  [Astronaut] = []
    
    init(){
        fetchAstronauts()
    }
    
    func fetchAstronauts (){
        if let urlString = Bundle.main.path(forResource: "astronauts", ofType: "json"){
        let url = URL(fileURLWithPath: urlString)
            guard let data = try? Data(contentsOf: url) else {return}
            let decoder = JSONDecoder()
            guard let decodedAstronauts = try? decoder.decode([Astronaut].self, from: data) else {return}
            self.astronauts = decodedAstronauts
            //print(decodedAstronauts)
        }
    }
    
}
