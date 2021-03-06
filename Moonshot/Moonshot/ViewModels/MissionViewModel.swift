//
//  MissionViewModel.swift
//  Moonshot
//
//  Created by David Burghoff on 28.11.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import Foundation

class ViewModel: ObservableObject{
    @Published var missions: [Mission] = []
    @Published var astronauts: [Astronaut] = []
    
    init(){
        missions = fetchData("missions")
        astronauts = fetchData("astronauts")
    }
    
    func fetchData<T: Codable> (_ file: String) -> T{
        guard let urlString = Bundle.main.path(forResource: file, ofType: "json")else {fatalError("error getting url")}
        let url = URL(fileURLWithPath: urlString)
            guard let data = try? Data(contentsOf: url) else {
                fatalError("Error loading data")
            }
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "y-MM-dd"
            decoder.dateDecodingStrategy = .formatted(formatter)
            guard let decoded = try? decoder.decode(T.self, from: data) else {
                fatalError("error decoding data")
            }
            return decoded
        }
    
}
