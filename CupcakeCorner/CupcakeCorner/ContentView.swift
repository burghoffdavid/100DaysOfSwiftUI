//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by David Burghoff on 01.12.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import SwiftUI

struct ContentView: View {
   @ObservedObject var order = OrderViewModel()
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select your cake Type", selection: $order.order.type){
                        ForEach(0..<Order.types.count){
                            Text(Order.types[$0])
                        }
                    }
                    Stepper(value: $order.order.quantity, in: 3...20){
                        Text("Number of cakes \(order.order.quantity)")
                    }
                }
                Section{
                    Toggle(isOn: $order.order.specialRequestEnabled.animation()){
                        Text("Any Special Requests")
                    }
                    if order.order.specialRequestEnabled{
                        Toggle(isOn: $order.order.extraFrosting){
                            Text("Add extra Frosting")
                        }
                        Toggle(isOn: $order.order.extraSprinkles){
                            Text("Add extra Sprinkles")
                        }
                    }
                }
                Section{
                    NavigationLink(destination: AdressView(order: order)){
                        Text("Delivery Details")
                    }
                }
            }
        .navigationBarTitle("Cupcake Corner")
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



class User: ObservableObject, Codable{
    enum CodingKeys: CodingKey{
        case name
    }
    @Published var name = "David Burghoff"
    
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

//
//func loadData(){
//    guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song")else {
//        print("Invalid URL")
//        return
//    }
//    let request = URLRequest(url: url)
//    URLSession.shared.dataTask(with: request){ data, response, error in
//        if let data = data {
//            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data){
//                DispatchQueue.main.async {
//                    self.results = decodedResponse.results
//                }
//                return
//            }
//        }
//        print("Fetch failed: \(error?.localizedDescription ?? "Unknown Error")")
//    }
//.resume()
//}
