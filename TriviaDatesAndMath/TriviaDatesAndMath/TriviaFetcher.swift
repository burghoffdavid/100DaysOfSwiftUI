//
//  TriviaFetcher.swift
//  TriviaDatesAndMath
//
//  Created by David Burghoff on 26.11.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import Foundation

public class TriviaFetcher: ObservableObject{
    @Published var trivias = [Trivia]()
    
    init() {
        load(type: "date", date: nil, number: nil, year: nil)
        load(type: "math", date: nil, number: nil, year: nil)
        load(type: "year", date: nil, number: nil, year: nil)
    }
    
    func delete (id: String){
        for (index, trivia) in trivias.enumerated(){
            let idToCheck = trivia.type + trivia.text
            if idToCheck == id {
                trivias.remove(at: index)
            }
        }
    }
    func load(type: String, date: String?, number: Float?, year: Int?){
        var urlString = "http://numbersapi.com/"
        
            if type == "date"{
                if let date = date{
                    urlString += "\(date)/"
                    urlString += type
                }else {
                    let currentDate = Date()
                    let formatter = DateFormatter()
                    formatter.timeStyle = .none
                    formatter.dateStyle = .short
                    formatter.locale = Locale(identifier: "en_US")
                    var dateString = formatter.string(from: currentDate)
                    dateString.removeLast(3)
                    urlString += "\(dateString)/date"
                }
            }
            if type == "math"{
                if number == nil{
                    urlString += "random/math"
                }else if let number = number {
                    urlString += "\(number)/year?notfound=floor"
                }
            }
            if type == "year"{
                if let year = year{
                    urlString += "\(year)?notfound=floor"
                }else{
                    urlString += "random/year"
                }
            }
        urlString += "?json"
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if let d = data {
                        
                        let decodedLists = try JSONDecoder().decode(Trivia.self, from: d)
                        DispatchQueue.main.async {
                            var foundNothing = true
                            for (index, trivia) in self.trivias.enumerated(){
                                if trivia.type == decodedLists.type{
                                    self.trivias[index] = decodedLists
                                    foundNothing = false
                                }
                            }
                            if foundNothing{
                                self.trivias.append(decodedLists)
                            }
                            self.trivias.sort{$0.type < $1.type}
                        }
                    }else{
                            print("No Data")
                        }
                }catch{
                            print("Error")
                        }
            }.resume()
                }
    }
}

