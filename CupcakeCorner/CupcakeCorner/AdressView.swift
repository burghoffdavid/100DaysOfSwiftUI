//
//  AdressView.swift
//  CupcakeCorner
//
//  Created by David Burghoff on 03.12.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import SwiftUI

struct AdressView: View {
    @ObservedObject var order: OrderViewModel
    var body: some View {
        Form{
            Section{
                TextField("Name", text: $order.order.name)
                TextField("Street Adress", text: $order.order.streetAdress)
                TextField("City", text: $order.order.city)
                TextField("ZIP", text: $order.order.zip)
            }
            Section{
                NavigationLink(destination: CheckoutView(order: order)){
                    Text("Check out")
                }
            }.disabled(order.order.hasValidAdress == false)
        }
        .navigationBarTitle("Delivery Details", displayMode: .inline)
    }
}

struct AdressView_Previews: PreviewProvider {
    static var previews: some View {
        AdressView(order: OrderViewModel())
    }
}
