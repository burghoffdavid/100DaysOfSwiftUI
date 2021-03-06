//
//  ContentView.swift
//  Trivia: Dates and Math
//
//  Created by David Burghoff on 25.11.19.
//  Copyright © 2019 David Burghoff. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var fetcher = TriviaFetcher()
    
    var currentDate: String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "en_GB")
        return formatter.string(from: date)
    }
    
    var body: some View {
        return NavigationView{
            ScrollView(.vertical){
               
                ForEach(self.fetcher.trivias){ trivia in
                            TriviaView(trivia: trivia)
                            
                        Spacer()
                    }
                
                .frame(maxWidth: .infinity)
                
            }
                .navigationBarTitle(Text("Trivia Facts!"), displayMode: .automatic)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()


    }
}

struct TriviaView: View{
   
    @State private var bodyText: String = "bkbkbkhbk"
    @State private var title: String = ""
    //var action: () -> Void
//    , action: {
//        self.fetcher.load(type: trivia.type, date: nil, number: nil, year: nil)
//    }
    @State private var trivia = Trivia(text: "sadsa", found: true, number: nil, type: "date", date: nil, year: nil)
    init(trivia: Trivia) {
        self.trivia = trivia
        print("test")
        print(trivia.type)
        print(trivia.text)

        self.bodyText = self.trivia.text
        self.title = "Random \(self.trivia.type) Trivia"
    }
    
    
    var body: some View{
        VStack(){
            HStack(alignment: .top){
                Text(title)
                    .font(.headline)
                    .autocapitalization(.words)
                Button(action: {}){
                    Image(systemName: "arrow.clockwise")
                        .animation(.easeInOut)
                }
                .accentColor(.primary)
            }
            .frame(width: 350, height: 50, alignment: .topLeading)
            .padding(.all)
            Spacer()
            VStack(alignment: .leading) {
                Text(bodyText)
                    .font(.body)
                    .padding(.all)
                    
            }
            Spacer()

        }
        .frame(width: 350, height: 250)
        .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing))
        .foregroundColor(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black, radius: 2, x: 2, y: 2)
        .animation(.easeIn)
     
            
        
    }
    
}
struct ButtonBoxedWithBackground: ViewModifier{
    func body(content: Content) -> some View{
        content
            .font(.headline)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing))
            .cornerRadius(10)
            .shadow(color: .black, radius: 2, x: 0, y: 0)
            .lineSpacing(10.0)
    }
}

struct BoxedLabelWithPackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 300, height: 300)
            .foregroundColor(.black)
            //.background(AngularGradient(gradient: Gradient(colors: [.green, .gray]), center: .top))
            .cornerRadius(10)
            .cornerRadius(10.0)
            .shadow(color: .black, radius: 2, x: 0, y: 0)
            .lineSpacing(10.0)
            .animation(.easeIn)
            .border(Color.black, width: 3)
        
    }
}
