//
//  ContentView.swift
//  WeSplit
//
//  Created by David Burghoff on 18.11.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double{
        let peopleCount = Double(Int(numberOfPeople) ?? 1 + 2)
        
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var grandTotal: Double{
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("Number of People", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                    
                }
                Section(header: Text("How much tip do you want to leave?")){
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0 ..< tipPercentages.count){
                            Text("\(self.tipPercentages[$0]) %")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Amount per Person")){
                    Text("$\(totalPerPerson, specifier: "%.2F")")
                }
                Section(header: Text("Original Grand Total")){
                    Text("$\(grandTotal, specifier: "%.2F")")
                }
            }
        }
    .navigationBarTitle("WeSplit")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
