//
//  MissionView.swift
//  Moonshot
//
//  Created by David Burghoff on 28.11.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    @ObservedObject var viewModel: ViewModel
    struct CrewMember{
        let role: String
        let astronaut: Astronaut
    }
    var mission: Mission
    var astronauts: [CrewMember] = []
    
    init (viewModel: ViewModel, mission: Mission){
        self.mission = mission
        self.viewModel = viewModel
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = viewModel.astronauts.first(where: { $0.id == member.name}){
                matches.append(CrewMember(role: member.role, astronaut: match))
            }else {
                fatalError("missing Astronaut")
            }
                
            
        }
        self.astronauts = matches
    }
    
    var body: some View {
        GeometryReader{ geometry in
            ScrollView(.vertical){
                VStack{
                    Image(self.mission.image)
                    .resizable()
                    .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    Text("Launch Date: \(self.mission.launchDateString)")
                        .font(.headline)
                    Text(self.mission.description)
                    .padding()
                    ForEach(self.astronauts, id: \.role){ crewMember in
                        NavigationLink(destination: AstronautDetailView(astronaut: crewMember.astronaut, viewModel: self.viewModel)){
                            HStack{
                                
                                    Image(crewMember.astronaut.id)
                                    .resizable()
                                        .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                        .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                    
                                    VStack(alignment: .leading){
                                        Text(crewMember.astronaut.name)
                                            .font(.headline)
                                        Text(crewMember.role)
                                            .foregroundColor(.secondary)
                                    
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
            .navigationBarTitle(Text(self.mission.displayName), displayMode: .inline)
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static var previews: some View {
        MissionView(viewModel: ViewModel(), mission: Mission(id: 1, launchDate: nil, crew: [], description: ""))
    }
}
