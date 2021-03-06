//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by David Burghoff on 03.12.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @State var showAlert = false
    @State var confirmationMessage = ""
    
    @ObservedObject var order: OrderViewModel
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView(.vertical){
                VStack{
                    Image("cupcakes")
                    .resizable()
                    .scaledToFit()
                        .frame(width: geo.size.width)
                    Text("Your total is $\(self.order.order.cost, specifier: "%.2F")")
                        .font(.title)
                    Button("Place Order"){
                        self.order.placeOrder()
                    }
                .padding()
                }
            }
        }
        .navigationBarTitle("Check Out", displayMode: .inline)

        .alert(isPresented: $showAlert) {
        Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: OrderViewModel())
    }
}
