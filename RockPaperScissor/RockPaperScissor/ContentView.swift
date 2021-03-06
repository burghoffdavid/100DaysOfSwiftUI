//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by David Burghoff on 23.11.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissor"]
    @State private var gameSelected = Int.random(in: 0...2)
    @State private var playerSelected = 0
    @State private var playerShouldWin = Bool.random()
    @State private var presentAlert = false
    @State private var alertText = ""
    
    var winOrLoos: String{
        if playerShouldWin{
            return "Win"
        }else {
            return "Loose"
        }
    }
    
    var body: some View {
        VStack(spacing: 20){
            Text("Lets play a game:")
            Text("I chose \(moves[gameSelected]) and you should \(winOrLoos)")
            Spacer()
            HStack(spacing: 20){
                ForEach(0 ..< moves.count){move in
                    Button(self.moves[move]){
                        self.playerSelected = move
                        self.didPlayerWin()
                    }
                }
                
            }
            Spacer()
                
            .alert(isPresented: $presentAlert) {
                Alert(title: Text("\(alertText)"), message: Text("lulz"), dismissButton: .default(Text("Continue")){
                    self.gameSelected = Int.random(in: 0...2)
                    self.playerShouldWin = Bool.random()
                    })
            }
        }
        
    }
    
    func didPlayerWin(){
        
        var movesToDeclareWin = moves
        
        
        if playerShouldWin{
            rotate(array: &movesToDeclareWin, k: 1)
            if moves[playerSelected] == movesToDeclareWin[gameSelected]{
                alertText = "Correct"
            }else{
                alertText = "Wrong"
            }
        }else {
            rotate(array: &movesToDeclareWin, k: -1)
            if moves[playerSelected] == movesToDeclareWin[gameSelected]{
                alertText = "Correct"
            }else {
                alertText = "Wrong"
            }
        }
        presentAlert = true
        
    }
    
    func rotate(array: inout [String], k: Int) {
        // Check for edge cases
        if k == 0 || array.count <= 1 {
            return // The resulting array is similar to the input array
        }

        // Calculate the effective number of rotations
        // -> "k % length" removes the abs(k) > n edge case
        // -> "(length + k % length)" deals with the k < 0 edge case
        // -> if k > 0 the final "% length" removes the k > n edge case
        let length = array.count
        let rotations = (length + k % length) % length

        // 1. Reverse the whole array
        let reversed: Array = array.reversed()

        // 2. Reverse first k numbers
        let leftPart: Array = reversed[0..<rotations].reversed()

        // 3. Reverse last n-k numbers
        let rightPart: Array = reversed[rotations..<length].reversed()

        array = leftPart + rightPart
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Array{
    mutating func rotateBy(positions: Int) {
       
        let positions2 = positions < 0 ? (self.count - abs(positions) % self.count) : positions % self.count
       
       if self.count % 2 == 0 {
        rotateFrom(position: 0, elements: self.count/2, stride: positions2)
        rotateFrom(position: 1, elements: self.count/2, stride: positions2)
       }else{
        rotateFrom(position: 0, elements: self.count, stride: positions2)
       }
   }
    private mutating func rotateFrom(position: Int, elements: Int, stride: Int)
    {
        var counter = elements
        var index = position
        var toMove = self[index]
        while counter > 0
        {
            let toSave = self[(index+stride) % self.count]
            self[(index+stride) % self.count] = toMove
            toMove = toSave
            index = (index+stride) % self.count
            counter -= 1
        }
    }
}
