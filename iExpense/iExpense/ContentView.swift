//
//  ContentView.swift
//  iExpense
//
//  Created by David Burghoff on 27.11.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var type: String
    var amount: Int
}
class Expenses: ObservableObject {
    @Published var items = [ExpenseItem](){
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let itemsData = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            if let decodedItems = try? decoder.decode([ExpenseItem].self, from: itemsData){
                self.items = decodedItems
                return
            }
        }
        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(expenses.items){item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        Text("$\(item.amount)")
                    }
                }
            .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showingAddExpense.toggle()
                }){
                    Image(systemName: "plus")
            })
                .sheet(isPresented: $showingAddExpense){
                    AddView(expenses: self.expenses)
            }
            
        }
        

    }
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}










//
//import SwiftUI
//
//class User: ObservableObject {
//    @Published var firstName: String = "Bilbo"
//    @Published var secondName: String = "Baggins"
//}
//
//struct ContentView: View {
//    @ObservedObject var user = User()
//    @State private var showingSheet = false
//
//    var body: some View {
//        NavigationView{
//            VStack{
//                Text("Hello your name is \(user.firstName) \(user.secondName)")
//                TextField("First Name:", text: $user.firstName)
//                TextField("First Name:", text: $user.secondName)
//                Button("Show Sheet"){
//                    self.showingSheet.toggle()
//                }
//
//            }
//
//        }
//        .sheet(isPresented: $showingSheet){SecondView(name: self.user.firstName)}
//    }
//}
//
//struct SecondView: View{
//    @Environment(\.presentationMode) var presentationMode
//    var name: String
//
//    var body: some View {
//        VStack{
//            Text("Hello, \(name)!")
//            Button("Dismiss"){
//                self.presentationMode.wrappedValue.dismiss()
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
