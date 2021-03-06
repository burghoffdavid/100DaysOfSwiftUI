//
//  ContentView.swift
//  MultiplicationEdutainment
//
//  Created by David Burghoff on 27.11.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import SwiftUI

struct MultiplyThis{
    var multiplicationTable: Int
    var multiplicateBy: Int
    
    
}

struct ContentView: View {
    @State private var selectedMultiplicationTable = 1
    @State private var selectedNumberOfQuestions = 1
    @State private var gameISRunning = false
    @State private var questionsAnswered = 0
    @State private var currentAnswer = 0
    @State private var userAnswer = ""
    @State private var animationAmount = 0.0
    @State private var gameWon = false
    @State private var score = 0
    
    let possibleTables = [1,2,3,4,5,6,7,8,9,10,11,12]
    let numberOfQuestions = ["5","10","20","all"]
    
    @State private var ComputedMultiplicationTable: [MultiplyThis] = []
    
    var body: some View {
        VStack (){
            if !gameISRunning{
                Form{
                    Section(header: Text("What number do you want to practice?")){
                        Stepper("\(selectedMultiplicationTable)", value: $selectedMultiplicationTable, in: 1...12)
                    }
                    Section(header: Text("How many Questions do you want to get asked?")){
                        Picker("\(numberOfQuestions[selectedNumberOfQuestions])", selection: $selectedNumberOfQuestions){
                            ForEach (0..<numberOfQuestions.count){
                                Text(self.numberOfQuestions[$0])
                            }
                            
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    Button("Start Game!"){
                        self.startGame()
                    }
                }
                .transition(.move(edge: .top))
            }
            if gameISRunning{
                Background{
                    VStack(alignment: .leading){
                        Text("Your score is: \(self.score)")
                            .padding(.all)
                            .foregroundColor(.white)
                                Spacer()
                                VStack(alignment: .center){
                                Text("What is \(self.ComputedMultiplicationTable[self.score].multiplicationTable) x \(self.ComputedMultiplicationTable[self.score].multiplicateBy)?")
                                .font(.headline)
                                .padding()
                                    .foregroundColor(.white)
                                TextField("???", text: self.$userAnswer)
                                    .keyboardType(.numberPad)
                                    .accentColor(Color.white)
                                    .multilineTextAlignment(.center)
                                .foregroundColor(Color.white)

                                
                                Button("Check Result"){
                                    withAnimation{
                                        self.animationAmount += 360
                                    }
                                    if self.checkAnswer(){
                                        print("Yay")
                                    }else {
                                        print("nay")
                                    }
                                }
                                .frame(width: 100, height: 50)
                                .padding(50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .background(LinearGradient(gradient: Gradient(colors: [.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .foregroundColor(Color.white)
                                
                                .rotation3DEffect(.degrees(self.animationAmount), axis: (x: 0, y: 1, z: 0))
                                    Spacer()
                                    
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                                      .background( LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .topLeading, endPoint: .topTrailing).edgesIgnoringSafeArea(.all))
                                   .transition(.scale)
                }
                .onTapGesture {
                    self.endEditing(true)
                }
                   
            }
        }
        .alert(isPresented: $gameWon, content:  {
            return Alert(title: Text("OK"), message: Text("Good job you got \(score) out of \(numberOfQuestions[selectedNumberOfQuestions]) Answers right!"), dismissButton: .default(Text("OK"), action: {
                self.gameISRunning = false
                self.score = 0
                self.userAnswer = ""
                self.currentAnswer = 0
            }))
        })

    }
    func checkAnswer () -> Bool{
        var correctAnswer = false
        if let userAnswer = Int(userAnswer){
            if userAnswer == currentAnswer{
                print("correct")
                self.userAnswer = ""
                
                score += 1
                currentAnswer = ComputedMultiplicationTable[score].multiplicationTable * ComputedMultiplicationTable[score].multiplicateBy
                
                correctAnswer =  true
            }
            questionsAnswered += 1
            let intNumberOfQuestions = Int(numberOfQuestions[selectedNumberOfQuestions]) ?? 30
                if questionsAnswered >= intNumberOfQuestions{
                    gameWon = true
                }
            
                
        }
        return correctAnswer
    }
    
    func startGame(){
        
            var tables = [MultiplyThis]()
            for i in 1..<31 {
                let newElement = MultiplyThis(multiplicationTable: possibleTables[selectedMultiplicationTable - 1], multiplicateBy: i)
                tables.append(newElement)
            }
        tables.shuffle()
        ComputedMultiplicationTable = tables
        
        currentAnswer = ComputedMultiplicationTable[questionsAnswered].multiplicationTable * ComputedMultiplicationTable[questionsAnswered].multiplicateBy
        withAnimation(.default){
            gameISRunning.toggle()
        }
        
    }
        private func endEditing(_ force: Bool) {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct Background<Content: View>: View {
    private var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        Color.white
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .overlay(content)
    }
}
