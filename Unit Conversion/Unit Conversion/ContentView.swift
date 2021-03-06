//
//  ContentView.swift
//  Unit Conversion
//
//  Created by David Burghoff on 23.11.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import SwiftUI



struct ContentView: View {
        
    @State private var temperature = ""
    @State private var temperatureTypeSelected = 0

    @State private var temperatureConvertToTypeSelected = 0
    
    var convertedTemperature: Double{
        
        var convertedTemp: Double = 0.0
        if let temperatureDouble = Double(temperature){
            if temperatureTypeSelected == temperatureConvertToTypeSelected {return temperatureDouble}
            
            
            if temperatureTypes[temperatureTypeSelected] == "Celcius"{
                if temperatureTypes[temperatureConvertToTypeSelected] == "Kelvin"{
                    convertedTemp = (temperatureDouble + 273.15)
                }else if temperatureTypes[temperatureConvertToTypeSelected] == "Fahrenheit"{
                    convertedTemp = ((temperatureDouble * 9/5) + 32.0)
                }
            }else if temperatureTypes[temperatureTypeSelected] == "Kelvin"{
                if temperatureTypes[temperatureConvertToTypeSelected] == "Celcius"{
                   convertedTemp = (temperatureDouble - 273.15)
               }else if temperatureTypes[temperatureConvertToTypeSelected] == "Fahrenheit"{
                    convertedTemp = ((temperatureDouble - 273.15) * 9/5 + 32.0)
               }
                
            }else if temperatureTypes[temperatureTypeSelected] == "Fahrenheit"{
                
                if temperatureTypes[temperatureConvertToTypeSelected] == "Kelvin"{
                    convertedTemp = ((temperatureDouble - 273.15) * 9/5 + 32)
                               
               }else if temperatureTypes[temperatureConvertToTypeSelected] == "Celcius"{
                    convertedTemp = ((temperatureDouble - 32.0) * 5/9)
               }
                
            }
            
        }
        return convertedTemp
    }
    
    let temperatureTypes = [
        "Celcius",
        "Kelvin",
        "Fahrenheit"
        ]
    let distanceTypes = [
         "Meters",
         "Kilometers",
         "Feet",
         "Yards",
         "Miles"
    ]
    
    @State private var distanceUnitSelected = 0
    @State private var distanceConvertToSelected = 0
    @State private var distanceInput = ""
    
    var convertedDistance: Double{
        var convertedDistance: Double = 0.0
        if let distanceInput = Double(distanceInput){
        
        
        
            switch distanceTypes[distanceUnitSelected] {
            case "Meters":
               var measurementInput = Measurement(value: distanceInput, unit: UnitLength.meters)
                switch distanceTypes[distanceConvertToSelected] {
                case "Kilometers":
                    measurementInput = measurementInput.converted(to: .kilometers)
                case "Feet":
                    measurementInput = measurementInput.converted(to: .feet)
                case "Yards":
                    measurementInput = measurementInput.converted(to: .yards)
                case "Miles":
                    measurementInput = measurementInput.converted(to: .miles)
                default:
                    break
               }
                convertedDistance = measurementInput.value
                
            case "Kilometers":
                var measurementInput = Measurement(value: distanceInput, unit: UnitLength.kilometers)
                switch distanceTypes[distanceConvertToSelected] {
                case "Meters":
                    measurementInput = measurementInput.converted(to: .meters)
                case "Feet":
                    measurementInput = measurementInput.converted(to: .feet)
                case "Yards":
                    measurementInput = measurementInput.converted(to: .yards)
                case "Miles":
                    measurementInput = measurementInput.converted(to: .miles)
                default:
                    break
                }
                convertedDistance = measurementInput.value
                
                
            case "Feet":
                var measurementInput = Measurement(value: distanceInput, unit: UnitLength.feet)
                switch distanceTypes[distanceConvertToSelected] {
                case "Kilometers":
                    measurementInput = measurementInput.converted(to: .kilometers)
                case "Meters":
                    measurementInput = measurementInput.converted(to: .meters)
                case "Yards":
                    measurementInput = measurementInput.converted(to: .yards)
                case "Miles":
                    measurementInput = measurementInput.converted(to: .miles)
                default:
                    break
                    
                }
                convertedDistance = measurementInput.value
                
            
            case "Yards":
                var measurementInput = Measurement(value: distanceInput, unit: UnitLength.yards)
                switch distanceTypes[distanceConvertToSelected] {
                case "Kilometers":
                    measurementInput = measurementInput.converted(to: .kilometers)
                case "Feet":
                    measurementInput = measurementInput.converted(to: .feet)
                case "Meters":
                    measurementInput = measurementInput.converted(to: .meters)
                case "Miles":
                    measurementInput = measurementInput.converted(to: .miles)
                default:
                    break
                }
                convertedDistance = measurementInput.value
                
            
            case "Miles":
                var measurementInput = Measurement(value: distanceInput, unit: UnitLength.miles)
                switch distanceTypes[distanceConvertToSelected] {
                case "Kilometers":
                    measurementInput = measurementInput.converted(to: .kilometers)
                case "Feet":
                    measurementInput = measurementInput.converted(to: .feet)
                case "Yards":
                    measurementInput = measurementInput.converted(to: .yards)
                case "Meters":
                    measurementInput = measurementInput.converted(to: .meters)
                default:
                    break
                }
                convertedDistance = measurementInput.value
                
            
            default:
                break
            }
        }
        
       return convertedDistance
        
    }

    
    
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Convert Temperatures")){
                    TextField("Input value", text: $temperature)
                        .keyboardType(.decimalPad)
                    Picker("Temperature type", selection: $temperatureTypeSelected){
                        ForEach(0..<temperatureTypes.count){
                            Text(self.temperatureTypes[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Select the Temperature Type you want to convert to")){
                    Picker("Convert to:", selection: $temperatureConvertToTypeSelected){
                        ForEach(0..<temperatureTypes.count){
                            Text(self.temperatureTypes[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Text("\(convertedTemperature, specifier: "%.2F")")
                    
                }
            
            
                Section(header: Text("Convert Meters")){
                    TextField("Input Value", text: $distanceInput)
                        .keyboardType(.decimalPad)
                    Picker("Distance Unit Type", selection: $distanceUnitSelected){
                        ForEach(0..<distanceTypes.count){
                            Text(self.distanceTypes[$0])
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Select the distance unit you want to convert to")){
                    Picker("Distance Unit Type", selection: $distanceConvertToSelected){
                            ForEach(0..<distanceTypes.count){
                                Text(self.distanceTypes[$0])
                            }
                        }
                    .pickerStyle(SegmentedPickerStyle())
                    Text("\(convertedDistance, specifier: "%.2F")")
                }
            
            }
            .navigationBarTitle(Text("Unit Conversion"))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
