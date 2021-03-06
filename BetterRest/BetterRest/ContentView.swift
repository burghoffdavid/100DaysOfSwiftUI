//
//  ContentView.swift
//  BetterRest
//
//  Created by David Burghoff on 24.11.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeUpTime
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
   
    

    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("When do you want to wake up?")){
                    DatePicker("Please choose a Date", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                Section(header: Text("Desired Amount of Sleep")){
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25){
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                Section(header: Text("Daily Coffe intake")){
                    Picker("Coffee intake", selection: $coffeeAmount){
                        ForEach(1..<21){ number in
                            Text("\(number) Cup of Coffee")
                        }
                    }
//                    Stepper(value: $coffeeAmount, in: 1...20){
//                        if coffeeAmount == 1 {
//                            Text("1 cup")
//                        }else {
//                            Text("\(coffeeAmount) cups")
//                        }
//                    }
                }
            }
        .navigationBarTitle("BetterRest")
        .navigationBarItems(trailing:
            Button(action: calcculateBedTime){
                Text("Calculate")
            })
                .alert(isPresented: $showAlert){
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        
        
    }
    
    static var defaultWakeUpTime: Date{
           var components = DateComponents()
           components.hour = 7
           components.minute = 0
           return Calendar.current.date(from: components) ?? Date()
       }
    func calcculateBedTime (){
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour  = (components.hour ?? 0) * 60 * 60
        let minute  = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is..."
            
        }catch{
            alertTitle = "Error"
            alertMessage = "Something went wrong"
           
        }
         showAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
