//
//  ContentView.swift
//  Animations
//
//  Created by David Burghoff on 27.11.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button("Tap Me"){
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)){
                self.animationAmount += 360
            }
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(Color.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//Button("Tap Me"){
//           withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)){
//               self.animationAmount += 360
//           }
//       }
//       .padding(50)
//       .background(Color.red)
//       .foregroundColor(Color.white)
//       .clipShape(Circle())
//       .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))

//
//Button("Tap me"){
//           self.animationAmount += 1
//       }
//   .padding(50)
//       .background(Color.red)
//       .foregroundColor(Color.white)
//   .clipShape(Circle())
//   .scaleEffect(animationAmount)
//   .blur(radius: (animationAmount - 1) * 3)
//       .animation(.default)
//



//Button("Tap Me") {
//    // self.animationAmount += 1
//}
//.padding(40)
//.background(Color.red)
//.foregroundColor(.white)
//.clipShape(Circle())
//.overlay(
//    Circle()
//        .stroke(Color.red)
//        .scaleEffect(animationAmount)
//        .opacity(Double(2 - animationAmount))
//        .animation(
//            Animation.easeOut(duration: 1)
//                .repeatForever(autoreverses: false)
//        )
//)
//.onAppear {
//    self.animationAmount = 2
//}
