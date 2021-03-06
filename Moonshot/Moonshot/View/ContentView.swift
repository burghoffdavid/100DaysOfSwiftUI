//
//  ContentView.swift
//  Moonshot
//
//  Created by David Burghoff on 28.11.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @State private var showingCrewNames = false
    var buttonText: String{
        let text = self.showingCrewNames ? "Show Launch Dates" : "Show Crew names"
        return text
    }
    
    
    var body: some View {
        NavigationView{
            List(viewModel.missions){ mission in
                    NavigationLink(destination: MissionView(viewModel: self.viewModel, mission: mission)){
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                        VStack(alignment: .leading){
                            Text(mission.displayName)
                                .font(.headline)
                            if self.showingCrewNames{
                                HStack{
                                    ForEach(mission.crew, id: \.name){crew in
                                        Text("\(crew.name), ")
                                    }
                                }
                            }else {
                                Text(mission.launchDateString)
                            }
                        }
                    }
                }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingCrewNames.toggle()
                }){
                    
                    Text(buttonText)
            })
            
            
            }
        
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension RandomAccessCollection {
    func indexed() -> IndexedCollection<Self> {
        IndexedCollection(base: self)
    }
}
struct IndexedCollection<Base: RandomAccessCollection>: RandomAccessCollection {
    typealias Index = Base.Index
    typealias Element = (index: Index, element: Base.Element)

    let base: Base

    var startIndex: Index { base.startIndex }

    var endIndex: Index { base.endIndex }

    func index(after i: Index) -> Index {
        base.index(after: i)
    }

    func index(before i: Index) -> Index {
        base.index(before: i)
    }

    func index(_ i: Index, offsetBy distance: Int) -> Index {
        base.index(i, offsetBy: distance)
    }

    subscript(position: Index) -> Element {
        (index: position, element: base[position])
    }
}
