//
//  ContentView.swift
//  Habit Tracking
//
//  Created by David Burghoff on 29.11.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var addNewHabitPresented = false
    @ObservedObject var habitVM = HabitViewModel()
    var body: some View {
        NavigationView{
            List(habitVM.habits){ habit in
                NavigationLink(destination: HabitDetailView(selectedHabit: habit, habitVM: self.habitVM)){
                    Text(habit.title)
                }
                .navigationBarTitle(Text("Habit Tracker"))
                .navigationBarItems(trailing: Button(action:{
                    self.addNewHabitPresented = true
                    }){
                        Image(systemName: "plus")
                }
                )
                    .sheet(isPresented: self.$addNewHabitPresented, content: {
                        addNewHabitView(habitVM: self.habitVM)
                    })
            }
        }
    }
}
struct HabitDetailView: View{
    
    @State var selectedHabit: Habit
    @ObservedObject var habitVM: HabitViewModel
    
    var body: some View{
        VStack{
            Text(selectedHabit.title)
                .font(.title)
                .padding()
            Text(selectedHabit.description)
                .padding()
            Stepper(value: $selectedHabit.count, in: 0...99){
                Text("\(selectedHabit.count) \(selectedHabit.unit)")
                Button("Save"){
                    for (index, habit) in self.habitVM.habits.enumerated(){
                        if habit.id == self.selectedHabit.id{
                            self.habitVM.habits[index].count = self.selectedHabit.count
                            self.habitVM.saveHabits()
                        }
                    }
                }
           }
        }
    }
}

struct addNewHabitView: View{
    @State var habitTitle: String = ""
    @State var habitDescription: String = ""
    @State var habitUnit: String = ""
    @ObservedObject var habitVM = HabitViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View{
        NavigationView {
            Form{
                TextField("Habit Title", text: $habitTitle)
                TextField("Habit Description", text: $habitDescription)
                TextField("Habit Unit", text: $habitUnit)
                Button("Add habit"){
                    let newHabit = Habit(title: self.habitTitle, description: self.habitDescription, unit: self.habitUnit, count: 0)
                    self.habitVM.habits.insert(newHabit, at: 0)
                    self.habitVM.saveHabits()
                     self.presentationMode.wrappedValue.dismiss()

                }
            }
        .navigationBarTitle(Text("Add Item"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
