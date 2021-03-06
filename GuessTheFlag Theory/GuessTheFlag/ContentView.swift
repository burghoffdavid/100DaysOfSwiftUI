//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by David Burghoff on 23.11.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingAlert = false
    var body: some View {
        Button("Show Alert"){
            self.showingAlert = true
        }
        .alert(isPresented: $showingAlert){
            Alert(title: Text("Hello Swift UI"), message: Text("Detail mss"), dismissButton: .default(Text("OK")))
            // sets showing alert to false automatically
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//MARK: - Gradients

// put inside stack to color whole zStack
//LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .topTrailing, endPoint: .bottomLeading)
//RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
//AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)

// MARK: - Colors

//Color(color: UIColor).frame(width: , height:)
//Color(.red).

// MARK: - Buttons
//Button(action :{
//               print("Button Tapped")
//           }) {
//               HStack{
//                   Image(systemName: "pencil")
//                   Text("Tap me")
//               }
//
//           }
