//
//  AstronautDetailView.swift
//  Moonshot
//
//  Created by David Burghoff on 28.11.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import SwiftUI

struct AstronautDetailView: View {
    let astronaut: Astronaut
    @ObservedObject var viewModel: ViewModel
    var missionsOfAstronauts: [Mission] = []
    
    init(astronaut: Astronaut, viewModel: ViewModel) {
        self.astronaut = astronaut
        self.viewModel = viewModel
        var matches = [Mission]()
        
        for mission in viewModel.missions {
            for crewMember in mission.crew{
                if crewMember.name == astronaut.id{
                    matches.append(mission)
                }
            }
        }
        self.missionsOfAstronauts = matches
        print(missionsOfAstronauts)
    }
var body: some View {
    GeometryReader { geometry in
        ScrollView(.vertical) {
            VStack {
                Image(self.astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width)

                Text(self.astronaut.description)
                    .padding()
                Text("Missions of this Astronaut")
                    .font(.headline)
                    .padding(.top)
                ForEach(self.missionsOfAstronauts){mission in
                    NavigationLink(destination: MissionView(viewModel: self.viewModel, mission: mission)){
                        HStack{
                            Image(mission.image)
                            .resizable()
                                .frame(width: 80, height: 80)
                            .clipShape(Circle())
                                .overlay(Circle().stroke(Color.primary, lineWidth: 1))
                            VStack(alignment: .leading){
                                Text(mission.displayName)
                                    .font(.headline)
                                Text(mission.launchDateString)
                                    .font(.subheadline)
                                
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                .buttonStyle(PlainButtonStyle())
                }
                Spacer(minLength: 25)
            }
        }
    }
    .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
}

}

struct AstronautDetailView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
